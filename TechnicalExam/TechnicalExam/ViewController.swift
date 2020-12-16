//
//  ViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Nothing is permanent in this world, not even our troubles!"
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         *   Tasks
         *   1. Add a UIImageView and UILabel below it using autolayout
         *   2. Change the text to your favorite quote
         *   3. Set it to any image that best illustrate the quote provided
         *   4. Display this screen for 3 seconds and then using storyboard either with UINavigationController or any navigate to TaskViewController
         *
        **/
        
        setupLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc = TasksViewController()
            let navigationController = UINavigationController(rootViewController: vc)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = navigationController
        }
    }

    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

}

