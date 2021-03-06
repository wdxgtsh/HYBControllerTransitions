Pod::Spec.new do |s|
  s.name         = "HYBControllerTransitions"
  s.version      = "1.2.0"
  s.summary      = "A very useful and helpful controller transition library.Custom push, pop, dismiss, and present transition. Just an API for calling it."
  s.description  = <<-DESC
                  This is an open source library for developers to use custom transition, including push, pop, present and dismiss. In the library, now has supported many kind of animations that we can see in many apps. The best thing for this library is, that developers only need to call an API, without others, to support custom transition. For more information, just see the document in detail or just download the demo project to have a look.  
                  This is an open source library for developers to use custom transition, including push, pop, present and dismiss. In the library, now has supported many kind of animations that we can see in many apps. The best thing for this library is, that developers only need to call an API, without others, to support custom transition. For more information, just see the document in detail or just download the demo project to have a look.  
                   DESC

  s.homepage     = "https://github.com/CoderJackyHuang/HYBControllerTransitions"
  s.screenshots  = "http://www.henishuo.com/wp-content/uploads/2016/03/bubble.gif", "http://www.henishuo.com/wp-content/uploads/2016/03/modal.gif", "http://www.henishuo.com/wp-content/uploads/2016/03/move.gif"
  s.license      = "MIT"
  s.author             = { "huangyibiao" => "" }
  s.social_media_url   = "http://henishuo.com"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CoderJackyHuang/HYBControllerTransitions.git", :tag => "#{s.version}" }
  s.source_files  = "HYBControllerTransitions", "*.{h,m}"

end
