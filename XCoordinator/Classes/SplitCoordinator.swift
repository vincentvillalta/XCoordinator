//
//  SplitCoordinator.swift
//  XCoordinator
//
//  Created by Paul Kraft on 30.07.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

///
/// SplitTransition offers different transitions common to a `UISplitViewController` rootViewController.
///
public typealias SplitTransition = Transition<UISplitViewController>

///
/// SplitCoordinator can be used as a basis for a coordinator with a rootViewController of type
/// `UISplitViewController`.
///
/// You can use all `SplitTransitions` and get an initializer to set a master and
/// (optional) detail presentable.
///
open class SplitCoordinator<RouteType: Route>: BaseCoordinator<RouteType, SplitTransition> {

    // MARK: - Initialization

    public override init(initialRoute: RouteType?) {
        super.init(initialRoute: initialRoute)
    }

    ///
    /// Creates a SplitCoordinator and sets the specified presentables as the rootViewController's
    /// viewControllers.
    ///
    /// - Parameter master:
    ///     The presentable to be shown as master in the `UISplitViewController`.
    ///
    /// - Parameter detail:
    ///     The presentable to be shown as detail in the `UISplitViewController`. This is optional due to
    ///     the fact that it might not be useful to have a detail page right away on a small-screen device.
    ///
    public init(master: Presentable, detail: Presentable?) {
        super.init(initialRoute: nil)
        rootViewController.viewControllers = [master.viewController, detail?.viewController].compactMap { $0 }
        master.presented(from: self)
        detail?.presented(from: self)
    }
}
