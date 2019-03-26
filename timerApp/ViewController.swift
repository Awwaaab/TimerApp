//  AppDelegate.swift
//  timerApp
//
//  Created by Awab Aly-mac on 7/5/18.
//  Copyright © 2018 MY_O. All rights reserved.

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
   
    
  
    var timer:Timer?
    var mytableview : UITableView?
    var alertTextfiled :UITextField?
    var seconds = 0
    var taskMO = [NSManagedObject]()
    var Names = [String]()
   // var isprused = true

    //  links main.storyboard
    
    
    
    @IBOutlet weak var stopwatchview_layout: NSLayoutConstraint!
    @IBOutlet weak var puseOUTlet: mycustomButton!
    @IBOutlet weak var stopwatchLable: UILabel!
    @IBOutlet weak var tableviewLayOUT: NSLayoutConstraint!
    @IBOutlet weak var myTableview: UITableView!
    @IBAction func goButton(_ sender: UIButton) {
     stopwatchview_layout.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        Runtimer()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableview.delegate = self
        mytableview?.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tableviewLayOUT.constant = 400
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    // timer funcs "auto timer"
    
    
    
    func timeStrIng(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minuts = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i" , hours,minuts,seconds)}
    
   @objc func timerUPdater(){
         seconds += 1
    stopwatchLable.text = timeStrIng(time: TimeInterval(seconds))}
   
    func Runtimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUPdater), userInfo: nil, repeats: true)
    }
    
    // tableview func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Names[indexPath.row]
        return cell
    }
    
    
    // Alert controller with text filed
 
    func SWAlertcontroller(){
        let alertcont = UIAlertController(title: "You're done ",message: "wrire your task" ,preferredStyle:.alert)
        let alertactCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let alertactSave = UIAlertAction(title: "Save", style: .default ,  handler: { (action) in
            self.saveDataTOCoredata()
        
        })
        
        alertcont.addAction(alertactCancel)
        alertcont.addAction(alertactSave)
        alertcont.addTextField{ (alertTextfiled) in
            alertTextfiled.placeholder = "write here"
            self.alertTextfiled=alertTextfiled}
        
        self.present(alertcont, animated: true, completion: nil)
        
    }
    
    func saveDataTOCoredata(){
        let entity = NSEntityDescription.entity(forEntityName: "Taskes", in: context)
        let task = NSManagedObject(entity: entity!, insertInto: context)
        task.setValue(alertTextfiled?.text, forKey: "name")
        do {try context.save()
        let secondAlertCon = UIAlertController(title: "task \(alertTextfiled!.text!) saved", message: nil, preferredStyle: .alert)
            let secondAlertAct = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.tableviewLayOUT.constant = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()}
            )   })
        secondAlertCon.addAction(secondAlertAct)
            self.present(secondAlertCon , animated: true , completion: nil)}
        
        catch {
            let erroralertcon = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
            let erroralertact = UIAlertAction(title: "Ok", style: .default, handler: nil)
            erroralertcon.addAction(erroralertact)
            self.present(erroralertcon , animated: true , completion: nil)
        }
}
  
    
    // fech from core data

    override func viewWillAppear(_ animated: Bool) {
        let requests = NSFetchRequest<NSFetchRequestResult>(entityName : "Taskes")
        do {
            let resaults = try context.fetch(requests)
            taskMO = resaults as! [ NSManagedObject]
            for taskmo in taskMO {
                Names.append(taskmo.value(forKey: "name") as! String)
                mytableview?.reloadData()
                 print(Names)
                
                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return Names.count
                }
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = UITableViewCell()
                    cell.textLabel?.text = Names[indexPath.row]
                    return cell
                }
            }
        }
        catch {print("Error")}
    }
    
    
    
    // buttons Actions
    
    
    @IBAction func stopButton(_ sender: UIButton) {
        timer?.invalidate()
        puseOUTlet.setTitle("Start", for: .normal)
        seconds = 0
        stopwatchLable.text = timeStrIng(time: TimeInterval(seconds))
        SWAlertcontroller()
    }
    @IBAction func puseButton(_ sender: UIButton) {
        if puseOUTlet.titleLabel?.text == "Puse" {
            puseOUTlet.setTitle("Start", for: .normal)
            timer?.invalidate()} else if puseOUTlet.titleLabel?.text == "Start" {
            puseOUTlet.setTitle("Puse", for: .normal)
            Runtimer()
        }
    }
    

}
// what happens when you touch out of the button :)//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        stopwatchview_layout.constant = 350
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
//    }



//
//override func viewWillAppear(_ animated: Bool) {
//    let request =  NSFetchRequest<NSFetchRequestResult>(entityName : "Taskes")
//    do {
//        let resaults = try context.fetch(request)
//        taskMO =  resaults as! [NSManagedObject]
//        for taskmo in taskMO {
//            Names.append(taskmo.value(forKey: "name" ) as! String)
//            myTableview.reloadData()
//
//        }
//    }
//    catch {print ("Error")}
//}

