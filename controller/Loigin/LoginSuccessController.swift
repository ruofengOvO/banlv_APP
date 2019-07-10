//
//  UIView.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/5.
//  Copyright © 2019 Rohlf W. All rights reserved.
//


import UIKit

class LoginSuccessController: UIViewController {
    
    let loginSignUp = LoginSignUpController()
    
    var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.applyGradient(colors: [.themePink, .themeBlue], type: .cross)
        
        initializeViews()
        addSubViews()
        addContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentAnimation()
    }
    
    func initializeViews() {
        animationView = loginSignUp.createView()
        animationView.layer.cornerRadius = 100
    }
    
    func addSubViews() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        view.addSubview(animationView)
    }
    
    func addContraints() {
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func presentAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            
            let transY = (self.view.frame.size.height * 1.2) / 200
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.animationView.transform = CGAffineTransform(scaleX: transY, y: transY)
            })
        }
    }
    
    @objc func handleTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
