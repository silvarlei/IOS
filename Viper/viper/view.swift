//
//  view.swift
//  Viper
//
//  Created by silvarlei soares on 15/04/22.
//

import Foundation
import UIKit


protocol AnyView{
    var presenter :AnyPresenter? {get set }
    func update(with users:[User])
    func update (with error:String)
}


class UserViewController: UIViewController , AnyView, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    var presenter: AnyPresenter?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       // table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        view.addSubview(grid)
        view.addSubview(tableView)
        Const()
        tableView.delegate = self
        tableView.dataSource = self
    }
    lazy var HelloLabelb:UILabel = {
       let label=UILabel()
       label.text = "alinhamento B"
       label.font = UIFont.systemFont(ofSize: 22)
       label.textColor = UIColor.black
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    private lazy var grid:UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
     
        stackView.addArrangedSubview(HelloLabelb)
        //stackView.addArrangedSubview(tableView)
       
       stackView.translatesAutoresizingMaskIntoConstraints = false
      
        return stackView
    }()
    private func Const(){
        grid.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 10 ).isActive = true
         
         grid.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: grid.topAnchor,constant:  70).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
     
        //tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 70).isActive = true
    }
    
    override func viewDidLayoutSubviews (){
        super.viewDidLayoutSubviews()
        
     
        //tableView.frame = view.bounds
    }
   
    var users:[User] = []
    func update(with users: [User]) {
        print("got users")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
     
    }
    
    func update(with error: String) {
        print(error)   // create the alert
        DispatchQueue.main.async {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
        }
        
    }
    

    
}
