//
//  Router.swift
//  Viper
//
//  Created by silvarlei soares on 15/04/22.
//

import Foundation
import UIKit


typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter{
    
    var entry : EntryPoint?{get}
    
    static func start()->AnyRouter
}

class UserRouter:AnyRouter{
    var entry: EntryPoint?
    

    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //ass vip
        
        
        var view : AnyView = UserViewController()
        var presenter :AnyPresenter = UserPresenter()
        var interactor : AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry  = view  as? EntryPoint
        
        return router
    }
    
    
}
