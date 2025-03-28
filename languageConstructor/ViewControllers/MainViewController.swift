//
//  MainViewController.swift
//  languageConstructor
//
//  Created by Руслан Арыстанов on 17.03.2025.
//

import UIKit

class MainViewController: UIViewController, UIDragInteractionDelegate, UIDropInteractionDelegate {
    private let progress = UIProgressView()
    private let nextButton = UIButton()
    private let dragText = UILabel()
    private let dropArea = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
        
        let dragInteraction = UIDragInteraction(delegate: self)
        dragText.addInteraction(dragInteraction)
               
        let dropInteraction = UIDropInteraction(delegate: self)
        dropArea.addInteraction(dropInteraction)
    }
    
    private func setElements(){
        dragText.text = "Hello"
        dragText.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dragText.textAlignment = .center
        dragText.backgroundColor = .gray
        dragText.textColor = .white
        dragText.layer.cornerRadius = 10
        dragText.layer.masksToBounds = true
        dragText.isUserInteractionEnabled = true
        dragText.translatesAutoresizingMaskIntoConstraints = false
        
        dropArea.backgroundColor = .lightGray
        dropArea.layer.cornerRadius = 10
        dropArea.layer.masksToBounds = true
        dropArea.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .lightGray
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(nextProgress), for: .touchUpInside)
        
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = 0.0
        progress.trackTintColor = .black
        
        view.addSubview(progress)
        view.addSubview(nextButton)
        view.addSubview(dragText)
        view.addSubview(dropArea)
        
        NSLayoutConstraint.activate([
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dropArea.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 50),
            dropArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropArea.widthAnchor.constraint(equalToConstant: 350),
            dropArea.heightAnchor.constraint(equalToConstant: 100),
            
            dragText.topAnchor.constraint(equalTo: dropArea.bottomAnchor, constant: 20),
            dragText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dragText.widthAnchor.constraint(equalToConstant: 100),
            dragText.heightAnchor.constraint(equalToConstant: 40),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - UIDragInteractionDelegate
        
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let provider = NSItemProvider(object: dragText.text! as NSString)
        let dragItem = UIDragItem(itemProvider: provider)
        dragItem.localObject = dragText // Сохраняем ссылку
        return [dragItem]
    }
    
    // MARK: - UIDropInteractionDelegate
        
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
        
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move) // Перетаскиваем объект
    }
        
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSString.self) { items in
            guard let text = items.first as? String else { return }
                        
            DispatchQueue.main.async {
                let newLabel = UILabel()
                newLabel.text = text
                newLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                newLabel.textAlignment = .center
                newLabel.backgroundColor = .gray
                newLabel.textColor = .white
                newLabel.layer.cornerRadius = 10
                newLabel.layer.masksToBounds = true
//                newLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
                newLabel.translatesAutoresizingMaskIntoConstraints = false
                
                self.dropArea.addSubview(newLabel)
                let offset = CGFloat(self.dropArea.subviews.count) * (newLabel.frame.width + 16)
                print(newLabel.frame.width)
                print(offset)
                NSLayoutConstraint.activate([
                    newLabel.leadingAnchor.constraint(equalTo: self.dropArea.leadingAnchor, constant: offset),
                    newLabel.topAnchor.constraint(equalTo: self.dropArea.topAnchor, constant: 16)
                ])
            }
        }
    }
    
    @objc func nextProgress() {
        let newValue = progress.progress + 0.5
        progress.setProgress(newValue, animated: true)
    }


}

