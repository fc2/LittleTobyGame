import Foundation

public class DataOptions{
    
    var answer = String()
    
    
    var labelsArray: [String] = ["angry", "celebrating", "confused","dizzy","guilty","happy","hiding","sad","speechless","surprised","tired"]
    
    var optionsArray = [String]()
    
    func getRandomLabel()-> Int{
        let random = Int(arc4random_uniform(11))
        return random
    }
    
    
    func generateOptions(){
        
        var index = getRandomLabel()
        answer = labelsArray[index]
        optionsArray.append(answer)
        
        var random1 = getRandomLabel()
        if(random1 == index){
            random1 = (random1+1)%10
            optionsArray.append(labelsArray[random1])
        }else{
            optionsArray.append(labelsArray[random1])
        }
        
        var random2 = Int()
        
        repeat {
            random2 = getRandomLabel()
        } while (random2 == index || random1 == random2)
        optionsArray.append(labelsArray[random2])
        
    }
    
    
    func shuffle(_: Array<String>)-> Array<String>{
        optionsArray = optionsArray.reversed()
        let random = Int(arc4random_uniform(3))
        if random == 2{
            return optionsArray
        }else{
            swap(&optionsArray[random], &optionsArray[2])
        }
        return optionsArray
    }
    
    func getOptions(){
        shuffle(optionsArray)
    }

    
    
}
