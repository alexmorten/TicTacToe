//
//  ViewController.swift
//  TicTacToe
//
//  Created by Alex on 23/07/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

import UIKit
import Darwin
class ViewController: UIViewController {
                            
    @IBOutlet var ticTagImg1: UIImageView!
    @IBOutlet var ticTagImg2: UIImageView!
    @IBOutlet var ticTagImg3: UIImageView!
    @IBOutlet var ticTagImg4: UIImageView!
    @IBOutlet var ticTagImg5: UIImageView!
    @IBOutlet var ticTagImg6: UIImageView!
    @IBOutlet var ticTagImg7: UIImageView!
    @IBOutlet var ticTagImg8: UIImageView!
    @IBOutlet var ticTagImg9: UIImageView!
    
     @IBOutlet var ticTacBtn1: UIButton!
     @IBOutlet var ticTacBtn2: UIButton!
     @IBOutlet var ticTacBtn3: UIButton!
     @IBOutlet var ticTacBtn4: UIButton!
     @IBOutlet var ticTacBtn5: UIButton!
     @IBOutlet var ticTacBtn6: UIButton!
     @IBOutlet var ticTacBtn7: UIButton!
     @IBOutlet var ticTacBtn8: UIButton!
     @IBOutlet var ticTacBtn9: UIButton!
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var resetBtn: UIButton!
    
    var plays=Dictionary<Int,Int>()
    var done=false
    var aiDeciding=false
    @IBAction func UIButtonClicked(sender:UIButton){
    messageLabel.hidden=true
       if !plays[sender.tag] && !aiDeciding && !done{
        setImageForSpot(sender.tag,player:1)
        checkForWin()
        aiTurn()
        }
        
       
    }
    @IBAction func rstBtnClicked(){
    done=false
    resetBtn.hidden=true
    messageLabel.hidden=true
        reset()
    }
    
    
    
    func reset(){
        plays=[:]
        ticTagImg1.image=nil
        ticTagImg2.image=nil
        ticTagImg3.image=nil
        ticTagImg4.image=nil
        ticTagImg5.image=nil
        ticTagImg6.image=nil
        ticTagImg7.image=nil
        ticTagImg8.image=nil
        ticTagImg9.image=nil
        
    }
    func whereToPlay(location:String,pattern:String)->Int{
        var leftPattern="011"
        var rightPattern="110"
        var middlePattern="101"
        
        switch location{
            
        case "top":
            if pattern==leftPattern{
                return 1
            }else if pattern == middlePattern{
                return 2
            }else  {
                return 3
            }
        case "bottom":
            if pattern==leftPattern{
                return 7
            }else if pattern == middlePattern{
                return 8
            }else  {
                return 9
            }
        case "middleAcross":
            if pattern==leftPattern{
                return 4
            }else if pattern == middlePattern{
                return 5
            }else  {
                return 6
            }
        case "left":
            if pattern==leftPattern{
                return 1
            }else if pattern == middlePattern{
                return 4
            }else  {
                return 7
            }
        case "middleDown":
            if pattern==leftPattern{
                return 2
            }else if pattern == middlePattern{
                return 5
            }else  {
                return 8
            }
        case "right":
            if pattern==leftPattern{
                return 3
            }else if pattern == middlePattern{
                return 6
            }else  {
                return 9
            }
        case "diagLeftRight":
            if pattern==leftPattern{
                return 1
            }else if pattern == middlePattern{
                return 5
            }else  {
                return 9
            }
        case "diagRightLeft":
            if pattern==leftPattern{
                return 3
            }else if pattern == middlePattern{
                return 5
            }else  {
                return 7
            }
        default: println("OMG SOMETHING BAD HAPPEND")
        return 5
        }
        
    }
    func setImageForSpot(spot:Int,player:Int){
        var playerMark:String = player==1 ? "x" : "o"
        plays[spot]=player
        switch spot{
        
        case 1:
            ticTagImg1.image=UIImage(named: playerMark)
        case 2:
            ticTagImg2.image=UIImage(named: playerMark)
        case 3:
            ticTagImg3.image=UIImage(named: playerMark)
        case 4:
            ticTagImg4.image=UIImage(named: playerMark)
        case 5:
            ticTagImg5.image=UIImage(named: playerMark)
        case 6:
            ticTagImg6.image=UIImage(named: playerMark)
        case 7:
            ticTagImg7.image=UIImage(named: playerMark)
        case 8:
            ticTagImg8.image=UIImage(named: playerMark)
        case 9:
            ticTagImg9.image=UIImage(named: playerMark)
        default: println("OMG")
        }
    
    }
    
    func checkForWin(){
        var whoWon=["I":0, "you":1]
        for (key,value) in whoWon{
            if( (plays[7]==value && plays[8]==value && plays[9]==value) ||
                (plays[4]==value && plays[5]==value && plays[6]==value) ||
                (plays[1]==value && plays[2]==value && plays[3]==value) ||
                
                (plays[1]==value && plays[4]==value && plays[7]==value) ||
                (plays[2]==value && plays[5]==value && plays[8]==value) ||
                (plays[3]==value && plays[6]==value && plays[9]==value) ||
                
                (plays[1]==value && plays[5]==value && plays[9]==value) ||
                (plays[3]==value && plays[5]==value && plays[7]==value)){
            messageLabel.hidden=false
            messageLabel.text="looks like \(key) won!"
            resetBtn.hidden=false
            done=true
            }
        
        }
    
    }
    func checkBottom(#value:Int)-> (location:String, pattern:String){
        return ("bottom",checkFor(value, inList: [7,8,9]))
    }
    func checkMiddleAcross(#value:Int)-> (location:String, pattern:String){
        return ("middleAcross",checkFor(value, inList: [4,5,6]))
    }
    func checkTop(#value:Int)-> (location:String, pattern:String){
        return ("top",checkFor(value, inList: [1,2,3]))
    }
    func checkLeft(#value:Int)-> (location:String, pattern:String){
        return ("left",checkFor(value, inList: [1,4,7]))
    }
    func checkMiddleDown(#value:Int)-> (location:String, pattern:String){
        return ("middleDown",checkFor(value, inList: [2,5,8]))
    }
    func checkRight(#value:Int)-> (location:String, pattern:String){
        return ("right",checkFor(value, inList: [3,6,9]))
    }
    func checkDiagLeftRight(#value:Int)-> (location:String, pattern:String){
        return ("diagLeftRight",checkFor(value, inList: [1,5,9]))
    }
    func checkDiagRightLeft(#value:Int)-> (location:String, pattern:String){
        return ("diagRightLeft",checkFor(value, inList: [3,5,7]))
    }
    
    
    func checkFor(value:Int, inList: [Int])->String{
    var conclusion=""
        for cell in inList{
            if plays[cell]==value{
            conclusion+="1"
            }else{
            conclusion+="0"
            }
        }
        return conclusion
    }
    
    func rowCheck(#value:Int)-> (location: String, pattern:String)?{
    var acceptableFinds=["011","110","101"]
   var findFuncs=[checkTop,checkBottom,checkLeft,checkRight,checkMiddleAcross,checkMiddleDown,checkDiagLeftRight,checkDiagRightLeft]
        for algorithm in findFuncs{
            var algorithmResults = algorithm(value:value)
            if find(acceptableFinds,algorithmResults.pattern){
            return algorithmResults
            }
        }
        return nil
    }
    func isOccupied(spot:Int)->Bool{
    return Bool(plays[spot])
    }
    func firstAvailable(#isCorner: Bool)-> Int?{
        var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
        for spot in spots{
            if !isOccupied(spot){
            return spot
            }
        }
        return nil
    
    }
    
    func aiTurn(){
        if done{
        return
        }
        aiDeciding=true
        //we have two in a row
        if let result = rowCheck(value:0){
            var whereToPlayResult = whereToPlay(result.location,pattern: result.pattern)
            if !isOccupied(whereToPlayResult){
            setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding=false
                checkForWin()
                return
            }
        }
        // Randomg BIG
          if (!(arc4random_uniform(11)==1)){
        //enemy has two
        
        if let result = rowCheck(value:1){
            var whereToPlayResult = whereToPlay(result.location,pattern: result.pattern)
            if !isOccupied(whereToPlayResult){
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding=false
                checkForWin()
                return
            }
        }
            //random medium1
        if !(arc4random_uniform(3)==1){
        //is center avaible?
        if !isOccupied(5){
        setImageForSpot(5, player: 0)
        aiDeciding=false
        checkForWin()
        return
        }
        //Random small 1
        if (arc4random_uniform(2)==1){
        //is a corner avaible?
        if let cornerAvailable = firstAvailable(isCorner: true){
        setImageForSpot(cornerAvailable, player: 0)
            aiDeciding=false
            checkForWin()
            return
        }
        //is a side avaible
        if let sideAvailable=firstAvailable(isCorner: false){
            setImageForSpot(sideAvailable, player: 0)
            aiDeciding=false
            checkForWin()
            return
        }
    }else //Random small turning point 1
        {
            //is a side avaible
            if let sideAvailable=firstAvailable(isCorner: false){
                setImageForSpot(sideAvailable, player: 0)
                aiDeciding=false
                checkForWin()
                return
            }
            //is a corner avaible?
            if let cornerAvailable = firstAvailable(isCorner: true){
                setImageForSpot(cornerAvailable, player: 0)
                aiDeciding=false
                checkForWin()
                return
            }
            }}else // Random med turning point 1
        {
      
            //Random small 1
            if (arc4random_uniform(2)==1){
                //is a corner avaible?
                if let cornerAvailable = firstAvailable(isCorner: true){
                    setImageForSpot(cornerAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
                //is center avaible?
                if !isOccupied(5){
                    setImageForSpot(5, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
                //is a side avaible
                if let sideAvailable=firstAvailable(isCorner: false){
                    setImageForSpot(sideAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
            }else //Random small turning point 1
            {
                //is a side avaible
                if let sideAvailable=firstAvailable(isCorner: false){
                    setImageForSpot(sideAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
                //is center avaible?
                if !isOccupied(5){
                    setImageForSpot(5, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
                //is a corner avaible?
                if let cornerAvailable = firstAvailable(isCorner: true){
                    setImageForSpot(cornerAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
            }
            
            
            }
          }else{ //Random BIG Turning point
            
            
            
            
            //is center avaible?
            if !isOccupied(5){
                setImageForSpot(5, player: 0)
                aiDeciding=false
                checkForWin()
                return
            }
            //Random small 2
            if (arc4random_uniform(2)==1){
                //is a corner avaible?
                if let cornerAvailable = firstAvailable(isCorner: true){
                    setImageForSpot(cornerAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
                //is a side avaible
                if let sideAvailable=firstAvailable(isCorner: false){
                    setImageForSpot(sideAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
            }else //Random small turning point 2
            {
                //is a side avaible
                if let sideAvailable=firstAvailable(isCorner: false){
                    setImageForSpot(sideAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
                //is a corner avaible?
                if let cornerAvailable = firstAvailable(isCorner: true){
                    setImageForSpot(cornerAvailable, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
            }
            //enemy has two
            if let result = rowCheck(value:1){
                var whereToPlayResult = whereToPlay(result.location,pattern: result.pattern)
                if !isOccupied(whereToPlayResult){
                    setImageForSpot(whereToPlayResult, player: 0)
                    aiDeciding=false
                    checkForWin()
                    return
                }
            }

            }
        messageLabel.hidden=false
        messageLabel.text="This is a tie..."
        
        resetBtn.hidden=false
        done=true
        aiDeciding=false
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

