//
//  ChatViewController.swift
//  Text Chat FireBase
//
//  Created by Максим Самусь on 12.08.2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.8672644496, green: 0.8492578864, blue: 0.8938599229, alpha: 1)
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadMessages()
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "date": Date().timeIntervalSince1970
            ])
            { error in
                print(error?.localizedDescription ?? "")
            }
        }
        messageTextField.text = ""
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    private func loadMessages() {
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { querySnapshot, error in
                self.messages = []
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    guard let snapshotDocuments = querySnapshot?.documents else { return }
                    for document in snapshotDocuments {
                        print(document.data())
                        guard let messageSender = document.data()["sender"] as? String else { return }
                        guard let messageBody = document.data()["body"] as? String else { return }
                        let newMessage = Message(sender: messageSender, body: messageBody)
                        self.messages.append(newMessage)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? MessageCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        cell.cellLabel.text = message.body
        cell.selectionStyle = .none
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = #colorLiteral(red: 1, green: 0.9661890864, blue: 0.7722665668, alpha: 1)
            cell.cellLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = #colorLiteral(red: 1, green: 0.9661890864, blue: 0.7722665668, alpha: 1)
            cell.cellLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        return cell
    }
}
