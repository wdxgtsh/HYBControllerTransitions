

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/logo.png" style="text-align: center; margin: 0 auto;">


#English Document  |  [中文文档](http://www.henishuo.com/transition-chinese-document/)

A helpful and very useful library for controller custom transition.

This is an open source library for developers to use custom transition,   
including push, pop, present and dismiss. In the library, now has supported  
many kind of animations that we can see in many apps. The best thing for this  
library is, that developers only need to call an API, without others, to support  
custom transition. For more information, just see the document in detail  
or just download the demo project to have a look.

#Buble Effect Transition

A custom modal transition that presents and dismiss a controller with an expanding bubble effect.  
The bubble transition only supports present and dismiis mode.

![image](https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/bubble.gif)


It's easy to use, just in the presenting controller callback event to add custom transition, like below:

```
- (void)onPresent {
  HYBBubbleFromBottomController *vc = [[HYBBubbleFromBottomController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationCustom;
  
  // Remember to own it strongly
  // Because delegate is weak reference, and it will be released after out of the function body.
  self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
    // You need to cast type to the real subclass type.
    HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
   
    // If you want to use Spring animation, set to YES.
    // Default is NO.
    //    bubble.animatedWithSpring = YES;
    bubble.bubbleColor = presented.view.backgroundColor;
    
    // If one have a navigation bar but another not, you should handle the difference by yourself.
    CGPoint center = [self.view viewWithTag:1010].center;
    center.y += 64;
    
    bubble.bubbleStartPoint = center;
  } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    // Do nothing and it is ok here.
    // If you really want to do something, here you can set the mode.
    // But inside the super class, it is set to be automally.
    // So you do this has no meaning.
    transition.transitionMode = kHYBTransitionDismiss;
  }];
  vc.transitioningDelegate = self.bubbleTransition;
  
  [self presentViewController:vc animated:YES completion:NULL];
}
```

For example, AController has an event onPresent, when it is clicked, it will be invoked.   
Now, AController needs to present BController, just use the code like above. In BController,  
you don't need to do anything. It is easy?

For more information, you should see the properties provided, almost every property has default value.  
So at many times, you don't need to worry about how to use.

#Modal Effect Transition

Modal transition animation, it will show usually half for the destination view controller's view,  
and scale the from view.

It only supports present and dismiss mode.

![image](https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/modal.gif)

It is easy to use just like bubble effect transition. Only use an API to finish your job. It looks like below:  

```
- (void)onPresent {
  HYBBubbleFromBottomController *vc = [[HYBBubbleFromBottomController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationCustom;
  
  // Remember to own it strongly
  // Because delegate is weak reference, and it will be released after out of the function body.
  self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
    // You need to cast type to the real subclass type.
    HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
   
    // If you want to use Spring animation, set to YES.
    // Default is NO.
    //    bubble.animatedWithSpring = YES;
    bubble.bubbleColor = presented.view.backgroundColor;
    
    // If one have a navigation bar but another not, you should handle the difference by yourself.
    CGPoint center = [self.view viewWithTag:1010].center;
    center.y += 64;
    
    bubble.bubbleStartPoint = center;
  } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    // Do nothing and it is ok here.
    // If you really want to do something, here you can set the mode.
    // But inside the super class, it is set to be automally.
    // So you do this has no meaning.
    transition.transitionMode = kHYBTransitionDismiss;
  }];
  vc.transitioningDelegate = self.bubbleTransition;
  
  [self presentViewController:vc animated:YES completion:NULL];
}
```
For example, AController has an event onPresent, when it is clicked, it will be invoked.   
Now, AController needs to present BController, just use the code like above. In BController,  
you don't need to do anything. It is easy?

For more information, you should see the properties provided, almost every property has default value.  
So at many times, you don't need to worry about how to use.

#Move Push/Pop Transition

The move transition animation, it looks like the transition animation of KeyNote move transition.  
When click a cell or a subview, then push to a view controller and you need  animation from the   
clicked view to the destination controller.  

It only supports push and pop mode.

![image](https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/move.gif)

For the custom push/pop transition animation, it is much harder than present/dismiss. The reason it that,   
when a controller was pushed, at this time, we just call init method, but the target view to transition  
is nil, so I have to try to solve this problem.

Now, I use a UIController category to solve it. In the pushed view controller, just set a target view like this:

```
// You must specify a target view with this.
self.hyb_toTargetView = imgView;
```

Now we use just like this:

```
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBMoveDetailController *vc = [[HYBMoveDetailController alloc] init];
  HYBGridModel *model = self.datasource[indexPath.item];
  vc.image = model.clipedImage;
  
  self.transition = [[HYBMoveTransition alloc] initWithPushed:^(UIViewController *fromVC, UIViewController *toVC, HYBBaseTransition *transition) {
    HYBMoveTransition *move = (HYBMoveTransition *)transition;
    HYBGridCell *cell = (HYBGridCell *)[collectionView cellForItemAtIndexPath:indexPath];
    move.targetClickedView = cell.imageView;
    
    move.animatedWithSpring = YES;
  } poped:^(UIViewController *fromVC, UIViewController *toVC, HYBBaseTransition *transition) {
    // Do nothing, unless you really need to.
  }];
  
  self.navigationController.delegate = self.transition;
  [self.navigationController pushViewController:vc animated:YES];
}
```

Here the example is that, when select a cell, transition from the cell's imageview to the target view (hyb_toTargetView).

Ok, until now, do you think it is really easy? I believe so!

#Thanks

Thanks to [andreamazz](https://github.com/andreamazz), I learn a lot from him.

#Contact

* GITHUB           : https://github.com/CoderJackyHuang/
* Author Blog      : http://www.henishuo.com/
* Email            : huangyibiao520@163.com

#MIT LICENSE

Copyright (c) 2016 CoderJackyHuang. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a  
copy of this software and associated documentation files (the "Software"),  
to deal in the Software without restriction, including  
without limitation the rights to use, copy, modify, merge, publish,  
distribute, sublicense, and/or sell copies of the Software, and to  
permit persons to whom the Software is furnished to do so, subject to  
the following conditions:  

The above copyright notice and this permission notice shall be included  
in all copies or substantial portions of the Software.  

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY  
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,  
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE  
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  
