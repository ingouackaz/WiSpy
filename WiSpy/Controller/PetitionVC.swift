//
//  PetitionVC.swift
//  WiSpy
//
//  Created by ingouackaz on 14/10/2015.
//
//

import UIKit


extension String {
    

    
    subscript (i: Int) -> Character
        {
        get {
            return self[self.startIndex.advancedBy(i)]
        }
    }
    
    subscript (i: Int) -> String {
        print("i 1 \(i)")

        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        print("i 2 \(r)")

        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}


@available(iOS 8.0, *)
class PetitionVC : UIViewController{
    
    var _hiddenMode: Int = 0
    var _petitionIndex: Int = 0
    var _characterDelete: Bool?
    var _defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var _petition: String = ""
    var _answer: String = ""

    
    @IBOutlet weak var _wiSpyAnswerLabel: UILabel!
    @IBOutlet weak var _wiSpyReceivingDataLabel: UILabel!
    @IBOutlet weak var _wiSpySendingData: UILabel!
    
    @IBOutlet weak var _petitionTextfield: UITextField!
    @IBOutlet weak var _questionTextfield: UITextField!
    @IBOutlet var _questionButton: UIButton!
    @IBOutlet var _wiSpyLogoImageView: UIImageView!
    
    
    var _tapOnce  : UITapGestureRecognizer = UITapGestureRecognizer()
    var _tapTwice  : UITapGestureRecognizer = UITapGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPetitonData()
        if _defaults.objectForKey("alreadyOpen") == nil {
            self.performSegueWithIdentifier("Tutorial", sender: nil)
        }
        _petitionTextfield.addTarget(self, action: "petitionTextfieldChanged:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _petitionTextfield.resignFirstResponder()
        _questionTextfield.resignFirstResponder()
        if _questionTextfield.text!.characters.count > 0 {
            if _hiddenMode != 5 {
                self.sendingData()
            }
        }
    }
    
    

    func enableInputClicksWhenVisible() -> Bool {
        return true
    }
    
    func sendingData() {
        _hiddenMode = 5
        _wiSpySendingData.hidden = false
        _questionButton.userInteractionEnabled = true
        _petitionTextfield.userInteractionEnabled = false
        _questionTextfield.userInteractionEnabled = false
        _wiSpyAnswerLabel.hidden = false
        _wiSpyReceivingDataLabel.hidden = false
        if _answer.characters.count == 0 {
            _answer = "Data not found "
        }
        _answer = ">_Wi-Spy :   " + _answer
        _wiSpyAnswerLabel.text = _answer
    }
    
    @IBAction func newQuestionPressed(sender: AnyObject) {
        self.initPetitonData()
        
        
    }
    
    
    func initPetitonData() {
        
        _tapOnce = UITapGestureRecognizer(target: self, action: "tapOnce:")
        _tapTwice = UITapGestureRecognizer(target: self, action: "tapTwice:")
        _wiSpyLogoImageView.addGestureRecognizer(_tapOnce)
        _wiSpyLogoImageView.addGestureRecognizer(_tapTwice)
        _tapOnce.numberOfTapsRequired = 1
        _tapTwice.numberOfTapsRequired = 2
        _wiSpySendingData.userInteractionEnabled = false
        _wiSpyAnswerLabel.hidden = true
        _wiSpyReceivingDataLabel.hidden = true
        // _wiSpyDataSended.hidden = true
        _wiSpySendingData.hidden = true
        //_dotLabel.hidden = true
        _hiddenMode = 0
        _petition = "Yes i support, Snowden"
        _answer = ""
        _petitionIndex = 1
        _characterDelete = false
        _petitionTextfield.text = ""
        _questionTextfield.text = ""
        _petitionTextfield.enabled = true
        _questionTextfield.text = ""
        _petitionTextfield.userInteractionEnabled = true
        _questionTextfield.userInteractionEnabled = true
    }
    
    
    func becomeHiddenMode() {
        _hiddenMode++
        
        let i = _petitionTextfield.text!.endIndex.advancedBy(-1)
        let newString : String = _petitionTextfield.text!.substringToIndex(i)
        _petitionTextfield.text = newString + "Y"
    }
    
    func becomeNormalMode(){
        if _petitionIndex < _petition.characters.count {
            let i = _petitionTextfield.text!.endIndex.advancedBy(-1)
            
            let newString: String = _petitionTextfield.text!.substringToIndex(i)
            _petitionTextfield.text = newString + _petition[_petitionIndex]
            _petitionIndex++
        }
        _hiddenMode++
    }
    
    func updateHiddenString(){
        let i = _petitionTextfield.text!.endIndex.advancedBy(-1)
        
        
        let newString: String = _petitionTextfield.text!.substringToIndex(i)
        _answer = _answer + _petitionTextfield.text!.substringFromIndex(i)
        if _petitionIndex < _petition.characters.count {
            _petitionTextfield.text = newString + _petition[_petitionIndex]
            _petitionIndex++
        }
    }
    
    func handleHiddenMode(){
        
        // delete
        if _hiddenMode == 1 {
            if _characterDelete == true {
                _characterDelete = false
            }
            else {
                if _petitionTextfield.text![_petitionTextfield.text!.characters.count - 1] == "Z" {
                    self.becomeNormalMode()
                }
                else {
                    self.updateHiddenString()
                }
            }
        }
    }
    
    @IBAction func tapOnce(sender: AnyObject) {
        _tapOnce.requireGestureRecognizerToFail(_tapTwice)
    }
    
    @IBAction func tapTwice(sender: AnyObject) {
        self.performSegueWithIdentifier("Tutorial", sender: nil)
    }
    
    func petitionTextfieldChanged(sender: AnyObject) {
        
        
        if _hiddenMode == 0 && _petitionTextfield.text![(_petitionTextfield.text!.characters.count) - 1] == "Z" {
            
            self.becomeHiddenMode()
        }
        else {
            
            self.handleHiddenMode()
        }
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count > 0 && textField.tag == 1 {
            self.sendingData()
        }
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        
        if textField.tag == 1 && _petitionTextfield.text == "" {
            _questionTextfield.resignFirstResponder()
            _petitionTextfield.becomeFirstResponder()
            
            let alertController = UIAlertController(title: "", message: "First answer the question ", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "Understood!", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count == 0 && range.length > 0 {
            if _hiddenMode == 1 {
                _characterDelete = true
                if _petitionIndex > 0 {
                    _petitionIndex--
                }
                if _answer.characters.count > 0 {
                    let i = _petitionTextfield.text!.endIndex.advancedBy(-1)
                    _answer = _answer.substringToIndex(i)
                }
            }
        }
        return true
    }
    
    
    func animateLabelShowText(newText: String, characterDelay delay: NSTimeInterval, forLavel label: UILabel) {
        label.text = ""
        for var i = 0; i < newText.characters.count; i++ {
            dispatch_async(dispatch_get_main_queue(), {
                label.text = ("\(label.text)%C")
            })
            UIDevice.currentDevice().playInputClick()
            NSThread.sleepForTimeInterval(delay)
        }
    }
    
}
