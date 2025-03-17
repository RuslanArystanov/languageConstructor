//
//  MainViewController.swift
//  languageConstructor
//
//  Created by Руслан Арыстанов on 17.03.2025.
//

import UIKit

class MainViewController: UIViewController {
    private let progress = UIProgressView()
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    
    private func setElements(){
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .lightGray
        nextButton.addTarget(self, action: #selector(nextProgress), for: .touchUpInside)
        
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = 0.0
        progress.trackTintColor = .black
        
        view.addSubview(progress)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func nextProgress() {
        var newValue = progress.progress + 0.5
        progress.setProgress(newValue, animated: true)
    }


}

