//
//  HomeViewModel.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import Foundation
import RxSwift
import RxCocoa


/// pagination
struct Pagination {
    var currentPage: Int
    var totalPage: Int
    
    init() {
        currentPage = 0
        totalPage = 1
    }
}


/// load type
enum LoadType {
    case loading
    case loaded(NetworkingError)
}


/// Networking Errors
enum NetworkingError {
    case none
    case noInternetConnection
    case custom(String)
    
    /// description for each case
    var localizedDescription: String {
        switch self {
        case .none: return ""
        case .noInternetConnection: return "No internet connection available"
        case .custom(let error): return error
        }
    }
}

/// Data to be placed in tableview or collection view
struct Data<T> {
    var items: T
    var loadType: LoadType = .loading
}

/// Home view model
final class HomeViewModel {
    
    /// last fetched index Path
    var lastFetchedIndexPath: IndexPath?
    
    /// pagination
    var pagination: Pagination
    
    /// items to be displayed in tableview
    let items = BehaviorRelay<Data<[User]>>(value: Data(items: []))
    
    /// disposable bag
    let bag: DisposeBag
    
    init() {
        self.bag = DisposeBag()
        self.pagination = Pagination()
    }
    
    /// fetch list from api
    private func fetchListFromAPI() {
        let Url = String(format: "https://reqres.in/api/users?page=\(pagination.currentPage+1)")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            guard let self = self, let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let data = json as? [String: Any], let result = data["data"] {
                    let currentPage: Int = data["page"] as! Int
                    let totalPages: Int = data["total_pages"] as! Int
                    self.pagination.totalPage = totalPages
                    self.pagination.currentPage = currentPage
                    
                    let arrayData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                    var items = self.items.value.items
                    let fetchedItems = try JSONDecoder().decode([User].self, from: arrayData)
                    items.append(contentsOf: fetchedItems)
                    if items.isEmpty {
                        self.generateError(of: .custom("No Data Found"))
                    } else {
                        DispatchQueue.main.async {
                            self.items.accept(Data(items: items))
                        }
                    }
                    
                } else {
                    self.generateError(of: .custom("Invalid Response"))
                }
            }
            catch(let error) {
                self.generateError(of: .custom(error.localizedDescription))
            }
        }.resume()
    }
    
    /// call api
    /// - Parameter indexPath: indexpath for which item is to be fetched
    func callAPI(of indexPath: IndexPath? = nil) {
        if lastFetchedIndexPath == indexPath && lastFetchedIndexPath != nil && pagination.currentPage == pagination.totalPage { return }
        
        if Reachability.isConnectedToNetwork() {
            lastFetchedIndexPath = indexPath
            fetchListFromAPI()
        } else {
            generateError(of: .noInternetConnection)
        }
    }
    
    /// generate error cases for tableview
    /// - Parameter type: type of error
    func generateError(of type: NetworkingError) {
        self.items.accept(Data(items: [], loadType: .loaded(type)))
    }
}
