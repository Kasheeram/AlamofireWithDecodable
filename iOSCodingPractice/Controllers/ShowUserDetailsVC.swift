//
//  ShowUserDetailsVC.swift
//  SuryaAssignToMe
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit
import CoreData

class ShowUserDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ServerAPIDelegate{

    let CellId = "CellId"
    var userItemArray = [data1]()
    var emailId:String?
    
    var appDelegate:AppDelegate?
    var context:NSManagedObjectContext?
    
    lazy var tableView:UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tv.delegate = self
        tv.dataSource = self
        tv.contentInset = UIEdgeInsets.zero
        tv.register(UserDetailTVCell.self, forCellReuseIdentifier: CellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "User Contacts List"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        
        addAutolayoutConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // check if data already present in local storage
        if self.someEntityExists(){
            fetchDataFromCoreData()
        }
        
        // runing a background API to get new response data
        fetchDataFromServer()
    }

    
    func addAutolayoutConstraints(){
        view.addSubview(tableView)
        
        navigationController?.navigationBar.isTranslucent = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    func API_CALLBACK_Error(errorNumber: Int, errorMessage: String, apiName: String) {
        // show some error message if response is failed
        showValidationAlert(message: errorMessage, presentVc : self) {
        }
    }
    

    // POST user email id by using call back method using protocol
    func fetchDataFromServer(){
        guard emailId != nil else { return }
        
        let param = ["emailId":emailId] as? [String:String]
                
        ServerInterface.sharedInstance.API_Request(params: param! as [String : AnyObject], delegate: self, apiName: "list", needErrorAlert: false)
        
    }
    
    // checking if data already present in local storage
    func someEntityExists() -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.includesSubentities = false
        
        var entitiesCount = 0
        
        do {
            entitiesCount = (try context?.count(for: fetchRequest))!
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return entitiesCount > 0
        
    }
    
    
    // Fetching data from Core Data by making Query
    func fetchDataFromCoreData(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context?.fetch(request) as NSArray?

            if (results?.count)! > 0{
                for result in results as! [NSManagedObject]{
                    
                    let data = data1()
                    
                    if let firstName = result.value(forKey: "firstName") as? String{
                        data.firstName = firstName
                    }
                    if let lastName = result.value(forKey: "lastName") as? String{
                        data.lastName = lastName
                    }
                    if let emailId = result.value(forKey: "emailId") as? String{
                        data.emailId = emailId
                    }
                    if let imageUrl = result.value(forKey: "imageUrl") as? String{
                        data.imageUrl = imageUrl
                    }
                    
                    userItemArray.append(data)
                }
            }
            tableView.reloadData()
            
        }catch{
            
        }
    }
    
    // call back respone
    func API_CALLBACK_POST_Data(result: Data){
        
        let data = result
        do {
            let users = try JSONDecoder().decode(UserData.self, from: data)
                saveDataToCoreData(newDatas:users)
        } catch let jsonErr {
            print("Error serializing json: ",jsonErr)
        }

    }
    
    // storing data to Core Data
    func saveDataToCoreData(newDatas:UserData){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["emailId"]
        
        do{
            if let results = try context?.fetch(request) as! [[String:Any]]? {
                let idSet = Set<String>(results.compactMap({ (dict) -> String? in
                    return dict["emailId"] as? String
                }))
                guard let newDatas = newDatas.items else { return }
                for newData in newDatas {
                    if let emailId = newData.emailId {
                        if !idSet.contains(emailId) {
                            let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context!)
                            user.setValue(newData.firstName, forKey: "firstName")
                            user.setValue(newData.lastName, forKey: "lastName")
                            user.setValue(newData.emailId, forKey: "emailId")
                            user.setValue(newData.imageUrl, forKey: "imageUrl")

                            do{
                                try context?.save()
                                print("SAVED")
                            }catch{

                            }

                            userItemArray.append(newData)
                            tableView.reloadData()
                        }
                    }
                }
                
            }
            
        }catch{
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! UserDetailTVCell
        cell.setValues(entity: userItemArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
