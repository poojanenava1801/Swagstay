//
//  AddRoomVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 04/03/23.
//

import UIKit
import SwiftyJSON

class AddRoomVC: UIViewController {
    @IBOutlet weak var tblRoom: UITableView!
    
    var arrRoom = JSON().arrayValue
    
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //btnSubmit.roundCorners([.topLeft,.topRight], radius: 120.0)
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: btnSubmit.frame.width, height:100), byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 100, height: 100.0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        btnSubmit.layer.mask = mask
        
        tblRoom.register(UINib(nibName: "AddRoomTableViewCell", bundle: nil), forCellReuseIdentifier: "AddRoomTableViewCell")
        let dict = ["adultCount":"1",
                    "ChildrenCount":"1",
                    "roomName":"Room 1",
                    "isShowAdd":true,
                    "isWithChild":false] as [String : Any]
        arrRoom.append(JSON(dict))
        tblRoom.reloadData()
        
    }
}
extension AddRoomVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRoom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddRoomTableViewCell", for: indexPath) as! AddRoomTableViewCell
        
        cell.lblRoom.text = arrRoom[indexPath.row]["roomName"].stringValue
        cell.viewSapraterAboveSvAddDelete.isHidden = !self.arrRoom[indexPath.row]["isShowAdd"].boolValue
        cell.svAddDelete.isHidden = !self.arrRoom[indexPath.row]["isShowAdd"].boolValue
        
        
        if self.arrRoom[indexPath.row]["adultCount"].stringValue != ""{
            if self.arrRoom[indexPath.row]["adultCount"].stringValue == "1"{
                cell.btnOneAdult.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnOneAdult.setTitleColor(.white, for: .normal)
                cell.btnTwoAdult.backgroundColor = .clear
                cell.btnTwoAdult.setTitleColor(.black, for: .normal)
                cell.btnThreeAdult.backgroundColor = .clear
                cell.btnThreeAdult.setTitleColor(.black, for: .normal)
            }else if self.arrRoom[indexPath.row]["adultCount"].stringValue == "2"{
                cell.btnTwoAdult.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnTwoAdult.setTitleColor(.white, for: .normal)
                cell.btnOneAdult.backgroundColor = .clear
                cell.btnOneAdult.setTitleColor(.black, for: .normal)
                cell.btnThreeAdult.backgroundColor = .clear
                cell.btnThreeAdult.setTitleColor(.black, for: .normal)
            }else{
                cell.btnThreeAdult.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnThreeAdult.setTitleColor(.white, for: .normal)
                cell.btnOneAdult.backgroundColor = .clear
                cell.btnOneAdult.setTitleColor(.black, for: .normal)
                cell.btnTwoAdult.backgroundColor = .clear
                cell.btnTwoAdult.setTitleColor(.black, for: .normal)
            }
        }else{
            cell.btnOneAdult.backgroundColor = .clear
            cell.btnOneAdult.setTitleColor(.black, for: .normal)
            cell.btnTwoAdult.backgroundColor = .clear
            cell.btnTwoAdult.setTitleColor(.black, for: .normal)
            cell.btnThreeAdult.backgroundColor = .clear
            cell.btnThreeAdult.setTitleColor(.black, for: .normal)
        }
        
        if self.arrRoom[indexPath.row]["ChildrenCount"].stringValue != ""{
            if self.arrRoom[indexPath.row]["ChildrenCount"].stringValue == "1"{
                cell.btnOneChildren.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnOneChildren.backgroundColor = .clear
                cell.btnTwoChildren.setTitleColor(.black, for: .normal)
                cell.btnThreeChildren.backgroundColor = .clear
                cell.btnThreeChildren.setTitleColor(.black, for: .normal)
                cell.btnOneChildren.setTitleColor(.white, for: .normal)
            }else if self.arrRoom[indexPath.row]["ChildrenCount"].stringValue == "2"{
                cell.btnTwoChildren.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnTwoChildren.setTitleColor(.white, for: .normal)
                cell.btnOneChildren.backgroundColor = .clear
                cell.btnOneChildren.setTitleColor(.black, for: .normal)
                cell.btnThreeChildren.backgroundColor = .clear
                cell.btnThreeChildren.setTitleColor(.black, for: .normal)
            }else{
                cell.btnThreeChildren.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnThreeChildren.setTitleColor(.white, for: .normal)
                cell.btnOneChildren.backgroundColor = .clear
                cell.btnOneChildren.setTitleColor(.black, for: .normal)
                cell.btnTwoChildren.backgroundColor = .clear
                cell.btnTwoChildren.setTitleColor(.black, for: .normal)
            }
        }else{
            cell.btnOneChildren.backgroundColor = .clear
            cell.btnOneChildren.setTitleColor(.black, for: .normal)
            cell.btnTwoChildren.backgroundColor = .clear
            cell.btnTwoChildren.setTitleColor(.black, for: .normal)
            cell.btnThreeChildren.backgroundColor = .clear
            cell.btnThreeChildren.setTitleColor(.black, for: .normal)
        }
        
        if self.arrRoom[indexPath.row]["isWithChild"].boolValue{
            cell.btntravelWithChildrenCheckBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            cell.viewChildren.isHidden = false
        }else{
            cell.btntravelWithChildrenCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            cell.viewChildren.isHidden = true
        }
       
       
        cell.btnDelete.isHidden = self.arrRoom.count == 1 ? true : false
        
        cell.btnOneAdult.addTap {
            self.arrRoom[indexPath.row]["adultCount"].stringValue = "1"
            self.tblRoom.reloadData()
        }
        cell.btnTwoAdult.addTap {
            self.arrRoom[indexPath.row]["adultCount"].stringValue = "2"
            self.tblRoom.reloadData()
        }
        cell.btnThreeAdult.addTap {
            self.arrRoom[indexPath.row]["adultCount"].stringValue = "3"
            self.tblRoom.reloadData()
        }
        
        cell.btnOneChildren.addTap {
            self.arrRoom[indexPath.row]["ChildrenCount"].stringValue = "1"
            self.tblRoom.reloadData()
        }
        cell.btnTwoChildren.addTap {
            self.arrRoom[indexPath.row]["ChildrenCount"].stringValue = "2"
            self.tblRoom.reloadData()
        }
        cell.btnThreeChildren.addTap {
            self.arrRoom[indexPath.row]["ChildrenCount"].stringValue = "3"
            self.tblRoom.reloadData()
        }
        
        cell.btntravelWithChildrenCheckBox.addTap {
                self.arrRoom[indexPath.row]["isWithChild"].boolValue = !self.arrRoom[indexPath.row]["isWithChild"].boolValue
            self.tblRoom.reloadData()
        }
        
        cell.btnDelete.addTap {
            self.arrRoom[indexPath.row-1]["isShowAdd"].boolValue = true
            self.arrRoom.remove(at:indexPath.row)
            self.tblRoom.reloadData()
        }
        
        cell.btnAddRoom.addTap {
            if self.arrRoom[indexPath.row]["adultCount"].stringValue != ""{
                self.arrRoom[indexPath.row]["isShowAdd"].boolValue = false
                let dict = ["adultCount":"",
                            "ChildrenCount":"",
                            "roomName":"Room \(self.arrRoom.count+1)",
                            "isShowAdd":true,
                            "isWithChild":false]
                self.arrRoom.append(JSON(dict))
                self.tblRoom.reloadData()
            }
        }

        return cell
    }
    
    
}
