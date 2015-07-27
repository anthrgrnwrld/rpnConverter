//
//  ViewController.swift
//  rpnCalculator
//
//  Created by Masaki Horimoto on 2015/06/27.
//  Copyright (c) 2015年 Masaki Horimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var outputInfixNotation: UILabel!
    @IBOutlet weak var outputRPN: UILabel!
    @IBOutlet weak var outputResult: UILabel!
    var expressionIN: [String] = []
    var kakkoCount: Int = 0
    
    @IBOutlet weak var cellIN: UIView!
    @IBOutlet weak var cellResult: UIView!
    @IBOutlet weak var cellRPN: UIView!
    
    @IBOutlet weak var descriptionRPN: UILabel!
    
    @IBOutlet var cellButtonArray: [UIButton]!
    
    let YOUR_ID = "ca-app-pub-3530000000000000/0123456789"  // Enter Ad's ID here
    let TEST_DEVICE_ID = "61b0154xxxxxxxxxxxxxxxxxxxxxxxe0" // Enter Test ID here
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputInfixNotation.adjustsFontSizeToFitWidth = true
        outputRPN.adjustsFontSizeToFitWidth = true
        outputResult.adjustsFontSizeToFitWidth = true
 
        
        for (index, val) in enumerate(cellButtonArray) {
            val.layer.borderWidth = 0.5
            val.layer.borderColor = UIColor.whiteColor().CGColor
        }
        
        cellIN.layer.borderWidth = 0.5
        cellIN.layer.borderColor = UIColor.whiteColor().CGColor
        
        cellResult.layer.borderWidth = 0.5
        cellResult.layer.borderColor = UIColor.whiteColor().CGColor
        
        cellRPN.layer.borderWidth = 0.5
        cellRPN.layer.borderColor = UIColor.whiteColor().CGColor
        
        let bannerView:GADBannerView = getAdBannerView()
        self.view.addSubview(bannerView)
        
    }
    
    private func getAdBannerView() -> GADBannerView {
        var bannerView: GADBannerView = GADBannerView()
        bannerView = GADBannerView(adSize:kGADAdSizeBanner)
        bannerView.frame.origin = CGPointMake(0, 20)
        bannerView.frame.size = CGSizeMake(self.view.frame.width, bannerView.frame.height)
        bannerView.adUnitID = "\(YOUR_ID)"
        bannerView.delegate = self
        bannerView.rootViewController = self
        
        var request:GADRequest = GADRequest()

        if AdMobTest {
            if SimulatorTest {
                request.testDevices = [kGADSimulatorID]
            } else {
                request.testDevices = [TEST_DEVICE_ID]
            }
        }
        
        bannerView.loadRequest(request)
        
        return bannerView
    }
    
    func adViewDidReceiveAd(adView: GADBannerView){
        println("adViewDidReceiveAd:\(adView)")
    }
    func adView(adView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError){
        println("error:\(error)")
    }
    func adViewWillPresentScreen(adView: GADBannerView){
        println("adViewWillPresentScreen")
    }
    func adViewWillDismissScreen(adView: GADBannerView){
        println("adViewWillDismissScreen")
    }
    func adViewDidDismissScreen(adView: GADBannerView){
        println("adViewDidDismissScreen")
    }
    func adViewWillLeaveApplication(adView: GADBannerView){
        println("adViewWillLeaveApplication")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressButton0(sender: AnyObject) {
        functionPressNumber("0")
    }

    @IBAction func pressButton1(sender: AnyObject) {
        functionPressNumber("1")
    }

    @IBAction func pressButton2(sender: AnyObject) {
        functionPressNumber("2")
    }
    
    @IBAction func pressButton3(sender: AnyObject) {
        functionPressNumber("3")
    }
    
    @IBAction func pressButton4(sender: AnyObject) {
        functionPressNumber("4")
    }
    
    @IBAction func pressButton5(sender: AnyObject) {
        functionPressNumber("5")
    }
    
    @IBAction func pressButton6(sender: AnyObject) {
        functionPressNumber("6")
    }
    
    @IBAction func pressButton7(sender: AnyObject) {
        functionPressNumber("7")
    }
    
    @IBAction func pressButton8(sender: AnyObject) {
        functionPressNumber("8")
    }
    
    @IBAction func pressButton9(sender: AnyObject) {
        functionPressNumber("9")
    }
    
    func functionPressNumber(strNumber :String) {
        
        var flag = true
        if expressionIN.isEmpty {
            outputInfixNotation.text = strNumber
        } else if outputInfixNotation.text == "0" {
            outputInfixNotation.text = strNumber
            flag = false
        } else if expressionIN.last == "0" && expressionIN[expressionIN.count - 2] <= "/" {
            let text = outputInfixNotation.text as NSString!
            outputInfixNotation.text = text.substringToIndex(expressionIN.count - 1) + strNumber
            flag = false
        } else if expressionIN.last == ")"{
            animationAlert()
            return
        } else {
            outputInfixNotation.text = outputInfixNotation.text! + strNumber
        }
        
        if flag {expressionIN.append(strNumber)}
        else {expressionIN.removeLast();expressionIN.append(strNumber)}
        
    }
    
    @IBAction func pressButtonOpenKakko(sender: AnyObject) {
        
        if expressionIN.isEmpty {
            outputInfixNotation.text = "("
            expressionIN.append("(")
        } else if (expressionIN.last <= "/" && expressionIN.last > ")") || expressionIN.last == "(" {
            outputInfixNotation.text = outputInfixNotation.text! + "("
            expressionIN.append("(")
        } else {
            animationAlert()
            return
        }
        
        kakkoCount++

    }

    @IBAction func pressButtonCloseKakko(sender: AnyObject) {

        if expressionIN.isEmpty {
            animationAlert()
            return
        } else if kakkoCount > 0 && (expressionIN.last > "/" || expressionIN.last == ")") {
            outputInfixNotation.text = outputInfixNotation.text! + ")"
            expressionIN.append(")")
        } else {
            animationAlert()
            return
        }
        
        kakkoCount--
        
    }
    
    func animationAlert() {
        
        let tmpColor = self.outputInfixNotation.backgroundColor
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: nil, animations: { () -> Void in
            self.outputInfixNotation.layer.opacity = 0.2
            self.cellIN.backgroundColor = UIColor.orangeColor()
            self.cellIN.layer.opacity = 0.3
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: nil, animations: { () -> Void in
            self.outputInfixNotation.layer.opacity = 1.0
            self.cellIN.backgroundColor = tmpColor
            self.cellIN.layer.opacity = 1.0
            }, completion: nil)
        
    }
    
    @IBAction func pressButtonWaru(sender: AnyObject) {
        functionPressOperator("/")
    }
    
    @IBAction func pressButtonKakeru(sender: AnyObject) {
        functionPressOperator("*")
    }
    
    @IBAction func pressButtonMinus(sender: AnyObject) {
        functionPressOperator("-")
    }
    
    @IBAction func pressButtonPlus(sender: AnyObject) {
        functionPressOperator("+")
    }
    
    func functionPressOperator(strOperator :String) {
        if expressionIN.isEmpty {expressionIN.append("0")}
        
        if expressionIN.last <= "/" && expressionIN.last > ")" {
            
            if expressionIN.last == strOperator {animationAlert()}
            
            expressionIN.removeLast()
            let str = outputInfixNotation.text! as NSString
            outputInfixNotation.text = str.substringToIndex(expressionIN.count)
        }
        
        var strDisplay: String
        if strOperator == "/" {strDisplay = "÷"}
        else if strOperator == "*" {strDisplay = "×"}
        else {strDisplay = strOperator}

        outputInfixNotation.text = outputInfixNotation.text! + strDisplay
        
        expressionIN.append(strOperator)
        
    }
    
    @IBAction func pressButtonEqual(sender: AnyObject) {
 
        if expressionIN.isEmpty {
            return
        } else if kakkoCount != 0 {
            animationAlert()
            return
        } else if expressionIN.last <= "/" && expressionIN.last > ")" {
            expressionIN.removeLast()
            let str = outputInfixNotation.text! as NSString
            outputInfixNotation.text = str.substringToIndex(expressionIN.count)
        }
 
        let token = getToken()
        
        let rpnBuffer = changeRpnWithToken(token)   //tokenから逆ポーランド記法に変換
        var flag = false
        
        outputRPN.text  = rpnBuffer.reduce("", combine: {
            
            if $0 == "" {return $0! + $1}
            else if $1 <= "/" {flag = true; return $0! + $1}
            else if flag == true {flag = false; return $0! + $1}
            else {return $0! + " " + $1}
            
        })

        self.view.bringSubviewToFront(cellRPN)
        self.view.bringSubviewToFront(outputRPN)
        self.view.bringSubviewToFront(descriptionRPN)
        animationSizeWithImageView(cellRPN, duration: 0.1)
        
        flag = false

        let calcResult = ViewController.calc(token)
        if calcResult != nil {
            
            if calcResult!.isNormal {
                var formatter = NSNumberFormatter()
                formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                formatter.groupingSeparator = ","
                formatter.groupingSize = 3
                outputResult.text = formatter.stringFromNumber(calcResult!)
            } else {
                outputResult.text = "Error!!"
            }
            
        } else {
            outputResult.text = "Error!!"
        }
        
        
        
    }
    
    //引数1のUIImageViewを拡大縮小するアニメーションを実行
    func animationSizeWithImageView(view: UIView, duration : Double) {
        
        UIView.animateWithDuration(duration / 2, delay: 0.0, options: nil, animations: { () -> Void in
            view.bounds.size.height = view.bounds.size.height * 1.2
        }, completion: nil)
        
        UIView.animateWithDuration(duration / 2, delay: duration / 2, options: nil, animations: { () -> Void in
            view.bounds.size.height = view.bounds.size.height / 1.2
        }, completion: nil)
        
    }
    
    class func calc(token:[String]) -> Float? {
        
        let exp = token.reduce("", combine: {
            if $1 > "/" {
                return $0 + $1 + ".0"
            } else {
                return $0 + $1
            }
        })
        let expression = NSExpression(format: exp)
        if let calcResult = expression.expressionValueWithObject(nil, context: nil) as? NSNumber {
            return calcResult.floatValue
        }else{
            return nil
        }
    }
    
    func changeRpnWithToken(rpnToken: [String]) -> [String] {
        
        var rpnBuffer: [String] = []
        var rpnStack: [String] = []
        var kakkoFlag: Bool = false
        let operatorPriorityDict: Dictionary = ["+": 0, "-": 0, "/": 1, "*": 1]
        
        for (index, val) in enumerate(rpnToken) {
            
            //1. 数字であれば、TokenをBufferに追加
            if rpnToken[index] > "/" {rpnBuffer.append(rpnToken[index])}
                
            //2. ")"であれば、Stackのlastから"("直前までBufferへ   "("は捨てる -> ループ終了
            else if rpnToken[index] == ")" {
                for (index2, val) in enumerate(rpnStack) {
                    
                    if rpnStack.last != "(" {rpnBuffer.append(rpnStack.last!); rpnStack.removeLast()}
                    else {rpnStack.removeLast(); break}
                    
                }
                
            //3. "("であれば、TokenをStackに追加
            } else if rpnToken[index] == "(" {rpnStack.append(rpnToken[index])}
                
                
            //4. Other
            else {
                
                //4-1. Stackが空でない
                while rpnStack.isEmpty == false {
                    
                    //4-2. Stackの最上段の演算子よりTokenの演算子の優先順位が低ければ、TokenをStackに追加 -> ループ終了
                    if operatorPriorityDict[rpnToken[index]] > operatorPriorityDict[rpnStack.last!] {
                        
                        rpnStack.append(rpnToken[index])
                        break
                        
                    //4-3. Stackの最上段の演算子よりTokenの演算子の優先順位が高いまたは同じであれば、StackをBufferに追加
                    } else {
                        
                        rpnBuffer.append(rpnStack.last!)
                        rpnStack.removeLast()
                        
                    }
                    
                }
                
                //4-4. Stackが空ならば、TokenをStackに追加
                if rpnStack.isEmpty {rpnStack.append(rpnToken[index])}
                
            }
            
            
        }
        
        //5. Tokenを全て読み出した場合、空になるまでStackをBufferに追加
        for index1 in rpnStack {
            if rpnStack.isEmpty {break}
            else {rpnBuffer.append(rpnStack.last!); rpnStack.removeLast()}
        }
        
        return rpnBuffer
        
    }
    

    
    func getToken() -> [String] {
        var token: [String] = []
        var expression = expressionIN
        
        expression.append("'")
        
        while expression.isEmpty != true {
            switch expression.first! {
            case "(",")","+","-","/","*":
                token.append(expression[0])
                expression.removeAtIndex(0)
            case "0","1","2","3","4","5","6","7","8","9":
                let (index, val) = reduce(enumerate(expression), (-1,"")) {
                    if $0.0 == -1 && $1.1 <= "/" {
                        return ($1.0, $0.1)
                    } else if $0.0 == -1 && $1.1 > "/" {
                        return ($0.0, $0.1 + $1.1)
                    } else {
                        return $0
                    }
                }
                token.append(val)
                expression.removeRange(0...(index-1))
            default:
                expression.removeAtIndex(0)
                
            }
        }
        
        return token
        
    }
    
    @IBAction func pressButtonBack(sender: AnyObject) {
        if expressionIN.isEmpty {return}

        if expressionIN.last == "(" {kakkoCount--}
        else if expressionIN.last == ")" {kakkoCount++}
        else {/* Do nothing */}
        
        expressionIN.removeLast()
        let str = outputInfixNotation.text! as NSString
        
        if expressionIN.isEmpty {outputInfixNotation.text = "0"}
        else {outputInfixNotation.text = str.substringToIndex(expressionIN.count)}
        
    }
    
    @IBAction func pressButtonClear(sender: AnyObject) {
        expressionIN.removeAll()
        outputInfixNotation.text = "0"
        outputRPN.text = "0"
        outputResult.text = "0"
        kakkoCount = 0
    }
    
}

