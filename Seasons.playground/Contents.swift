import UIKit
import PlaygroundSupport
import AVFoundation

extension UILabel {
    func fadeIn(_ duration: TimeInterval = 3.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveLinear, animations: {
            self.alpha = 1.0
        }, completion: completion)
        
    }
    
    func fadeOut(_ duration: TimeInterval = 2.0, delay: TimeInterval = 5.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: completion)
        
        
        
    }
}


var containerView = UIView(frame: CGRect(x: 5, y: 5, width: 550, height: 630))
containerView.backgroundColor = UIColor.white

var springSong: AVAudioPlayer!

var imageTree = UIImage(named: "SpringTree.png")

var imageTreeView = UIImageView(image: imageTree)

var flower : UIImage!

var flowerView : UIImageView!

let path = Bundle.main.path(forResource: "Birds-singing-relaxation.mp3", ofType:nil)!
let url = URL(fileURLWithPath: path)

do {
    let sound = try AVAudioPlayer(contentsOf: url)
    springSong = sound
    sound.play()
} catch {
    // couldn't load file :(
}


containerView.addSubview(imageTreeView)


/*:
 ## Creating the animator
 */
let animator = UIDynamicAnimator(referenceView: containerView)

var gravity: UIGravityBehavior!

var collision: UICollisionBehavior!

var itemBehaviour: UIDynamicItemBehavior!


let tapGesture = UITapGestureRecognizerHelper(view: containerView) { location in
    
    let num = arc4random_uniform(3)
    if num == 0
    {
     flower = UIImage(named: "springFlwr2.png")
    }
    else if num == 1
    {
     flower = UIImage(named: "whiteFlower.png")
    }
    
    else {
     flower = UIImage(named: "springLeaf")
    }
    
    flowerView = UIImageView(image: flower)
    flowerView.frame.origin.x=location.x;
    flowerView.frame.origin.y=location.y;
    imageTreeView.addSubview(flowerView)
    
    gravity = UIGravityBehavior(items: [flowerView])
    
    animator.addBehavior(gravity)
    collision = UICollisionBehavior(items: [flowerView])
    collision.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(collision)
    
    itemBehaviour = UIDynamicItemBehavior(items: [flowerView])
    itemBehaviour.elasticity = 0.3
    
    itemBehaviour.resistance = 0.5
    itemBehaviour.allowsRotation=true
    
    animator.addBehavior(itemBehaviour)
  
 
}



let springLabel = UILabel(frame: CGRect(x:80,y:390,width:550, height:100))
springLabel.textColor = UIColor.red
springLabel.text = " O, wind, if winter comes, can spring be far behind?"

springLabel.isUserInteractionEnabled=true
springLabel.alpha=0
springLabel.shadowColor=UIColor.black
imageTreeView.addSubview(springLabel)


//springLabel.fadeIn { _ in springLabel.fadeOut{ _ in springLabel.fadeIn() } }

springLabel.fadeIn { _ in springLabel.fadeOut() }

PlaygroundPage.current.liveView=containerView









