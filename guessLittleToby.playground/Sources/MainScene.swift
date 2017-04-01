
import Foundation
import SpriteKit

public class MainScene : SKScene{
    
    var personName = String()
    
    let labelStatement = SKLabelNode(text: "What I look like when I am:")
    
    var imagesOptions = [(SKSpriteNode,SKSpriteNode)]()
    
    let labelDescription = SKLabelNode()
  
    var feedback = SKSpriteNode()
    var buttonNext = SKSpriteNode()
    
    
    let round = Round()
    var roundOptions = Array<String>()
    
    var roundCount:Int = 0
    
    var correct = Bool()
    
    
    override public func didMove(to view: SKView) {
        
        let frame = CGRect(x: 0, y: 0, width: 500, height: 600)
        self.backgroundColor = .white
        
        
        roundOptions = round.getOptions()
      //print(round.answer)
      //print(roundOptions)
        loadOptions()
        
        setStatement()
        
        setDescreptionLabel()
        
        setFeedback()
        
        print(imagesOptions[0].1.description)
        print(personName)
    }
    

    
    func setStatement(){
        labelStatement.fontColor = SKColor.black
        labelStatement.position = CGPoint(x: self.frame.midX, y: self.frame.midY+100)
        labelStatement.fontSize = 25
        self.addChild(labelStatement)
    }
    
    
    
    func setDescreptionLabel(){
        labelDescription.text = self.round.answer
        labelDescription.fontName = ".SFUIText"
        labelDescription.fontSize = 22
        labelDescription.fontColor = SKColor.black
        labelDescription.position = CGPoint(x:self.frame.midX, y:275)
        labelDescription.zPosition = 10
        self.addChild(labelDescription)
    }
    
    
    
    func loadOptions(){
        imagesOptions.append((SKSpriteNode(imageNamed:roundOptions[0]), SKSpriteNode(imageNamed: "blank")))
        imagesOptions.append((SKSpriteNode(imageNamed:roundOptions[1]), SKSpriteNode(imageNamed: "blank")))
        imagesOptions.append((SKSpriteNode(imageNamed:roundOptions[2]), SKSpriteNode(imageNamed: "blank")))
        
        //adding the images
        imagesOptions[0].0.position = CGPoint(x:self.frame.midX-145, y:self.frame.midY*0.95);
        self.addChild(imagesOptions[0].0)
        imagesOptions[1].0.position = CGPoint(x:self.frame.midX, y:self.frame.midY*0.95);
        self.addChild(imagesOptions[1].0)
        imagesOptions[2].0.position = CGPoint(x:self.frame.midX+145, y:self.frame.midY*0.95);
        self.addChild(imagesOptions[2].0)
        
        //adding the targets
        
        imagesOptions[0].1.position = CGPoint(x:self.frame.midX-145, y:imagesOptions[0].0.position.y-90);
        self.addChild(imagesOptions[0].1)
        imagesOptions[1].1.position = CGPoint(x:self.frame.midX, y:imagesOptions[1].0.position.y-90);
        self.addChild(imagesOptions[1].1)
        imagesOptions[2].1.position = CGPoint(x:self.frame.midX+145, y:imagesOptions[2].0.position.y-90);
        self.addChild(imagesOptions[2].1)
        
        
    }
    
    
    func setFeedback(){
        feedback = SKSpriteNode(imageNamed: "instruction")
        feedback.position = CGPoint(x: self.frame.midX, y: self.frame.minY+45)
        self.addChild(feedback)
        
    }
    
    
    func setRightAnswerFeedback(){
        feedback.texture = SKTexture(imageNamed: "rightAnswer")
        labelDescription.fontColor = SKColor.init(red: 96/255, green: 205/255, blue: 233/255, alpha: 1.0)
        labelDescription.fontName = ".SFUIText-Medium"
    }
    
    
    func setWrongAnswerFeedback(){
        feedback.texture = SKTexture(imageNamed: "wrongAnswer")
        labelDescription.fontColor = SKColor.black
        labelDescription.fontName = ".SFUIText"
    }
    
    func setNextbutton(){
        buttonNext = SKSpriteNode(imageNamed: "btn_next_normal")
        buttonNext.position = CGPoint(x: self.frame.midX+230, y: self.frame.minY+45)
        self.addChild(buttonNext)
    }
    
    
    func newRound(){
        correct = false
        imagesOptions.removeAll()
        roundOptions = round.getOptions()
        self.removeAllChildren()
        labelDescription.removeFromParent()
        setStatement()
        setDescreptionLabel()
        feedback.removeFromParent()
        setFeedback()
        loadOptions()
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if (buttonNext.contains(touchLocation) && self.roundCount<5 && self.correct){
            self.buttonNext.texture = SKTexture(imageNamed: "btn_next_pressed")
            print(roundCount)
            roundCount+=1
            self.newRound()
            
        }else if(buttonNext.contains(touchLocation) && roundCount==5){
            //end of the game
            
            let sceneMoveTo = LastScene(size: self.size)
            sceneMoveTo.scaleMode = self.scaleMode
            sceneMoveTo.personName = personName
            
            let transition = SKTransition.moveIn(with: .right, duration: 0.8)
            self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
            
        }
    }
    
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let touchLocation = touch.location(in: self)
            labelDescription.position.x = touchLocation.x
            labelDescription.position.y = touchLocation.y
        }
    }
    
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //only recognize in the blanket areas
        for blank in self.imagesOptions{
            if blank.1.frame.contains(self.labelDescription.position){
                if (imagesOptions[roundOptions.index(of: round.answer)!].1.frame.contains(labelDescription.position)){
                    
                    setRightAnswerFeedback()
                    
                    self.correct = true
                    setNextbutton()
                    
                }
                else{
                    
                    setWrongAnswerFeedback()
                    print("incorrect")
                    
                }
            }
        }
    }
    
}
