//
//  Animation+Navigation.swift
//  XCoordinator
//
//  Created by Paul Kraft on 16.09.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

class NavigationAnimationDelegate: NSObject, UINavigationControllerDelegate {

    // MARK: - Stored properties

    var animation: Animation? {
        didSet {
            print(animation)
        }
    }
    weak var delegate: UINavigationControllerDelegate?

    // MARK: - UINavigationControllerDelegate

    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print(#function)
        return animation?.presentationAnimation as? UIViewControllerInteractiveTransitioning
            ?? delegate?.navigationController?(navigationController, interactionControllerFor: animationController)
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        func transitionAnimation() -> UIViewControllerAnimatedTransitioning? {
            print(#function)
            switch operation {
            case .push:
                return animation?.presentationAnimation
            case .pop:
                return animation?.dismissalAnimation
            case .none:
                assertionFailure()
                return nil
            }
        }
        return transitionAnimation()
            ?? delegate?.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        delegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        delegate?.navigationController?(navigationController, willShow: viewController, animated: animated)
    }

    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return delegate?.navigationControllerSupportedInterfaceOrientations?(navigationController)
            ?? navigationController.visibleViewController?.supportedInterfaceOrientations
            ?? .all
    }

    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return delegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController)
            ?? navigationController.visibleViewController?.preferredInterfaceOrientationForPresentation
            ?? UIApplication.shared.statusBarOrientation
    }
}

extension UINavigationController {
    internal var animationDelegate: NavigationAnimationDelegate? {
        return delegate as? NavigationAnimationDelegate
    }

    public var coordinatorDelegate: UINavigationControllerDelegate? {
        return animationDelegate?.delegate
    }
}
