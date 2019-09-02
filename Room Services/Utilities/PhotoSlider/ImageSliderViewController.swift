import UIKit

open class ImageSliderViewController: UIViewController, ImageSliderViewDelegate {

    public let imageSliderView: ImageSliderView
    public let pageControl = UIPageControl()

    public init(currentIndex: Int, imageUrls: [String]) {
        imageSliderView = ImageSliderView(currntIndex: currentIndex, imageUrls: imageUrls)
        imageSliderView.contentMode = .scaleToFill
        //imageSliderView.layer.cornerRadius = 25.0
        super.init(nibName: nil, bundle: nil)
        print("currentIndex + imageUrls ",currentIndex, imageUrls)
        imageSliderViewImageSwitch(currentIndex, count: imageUrls.count, imageUrl: imageUrls[currentIndex])
    }

    public required init?(coder aDecoder: NSCoder) {
        imageSliderView = ImageSliderView(currntIndex: 0, imageUrls: [])
        super.init(coder: aDecoder)
//        imageSliderView.contentMode = .scaleToFill
        imageSliderViewImageSwitch(0, count: 0, imageUrl: nil)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
//        view.layer.cornerRadius = 12.0

        imageSliderView.delegate = self
        imageSliderView.translatesAutoresizingMaskIntoConstraints = false
//        imageSliderView.contentMode = .scaleToFill
        view.addSubview(imageSliderView)
        setImageSliderViewConstraints()

        pageControl.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pageControl)
//        view.contentMode = .scaleToFill
        setDisplayLabelConstraints()
//        let sizeHeight = (GlobalManager.ScreenSize.SCREEN_MAX_LENGTH/2)/2
//        print(sizeHeight)
//        let buttonLeft = UIButton(frame: CGRect(x: 20, y:Int(sizeHeight-80) , width: 50, height: 50))
//        buttonLeft.setImage(UIImage.init(named: "leftArrow"), for: .normal)
//        buttonLeft.addTarget(self, action: #selector(buttonLeftAction), for: .touchUpInside)
//        view.addSubview(buttonLeft)
        
        
        
    }
//    @objc func buttonLeftAction(sender: UIButton!) {
//        print("buttonLeft tapped")
//
//     //   imageSliderViewImageSwitch(GlobalManager.sharedInstance.index, count: GlobalManager.sharedInstance.count, imageUrl: GlobalManager.sharedInstance.imageUrl)
//
//
//
//    }

    open func setImageSliderViewConstraints() {
        let imageSliderViewHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[imageSliderView]-0-|",
                                                                                      options: [],
                                                                                      metrics: nil,
                                                                                      views: ["imageSliderView": imageSliderView])
        view.addConstraints(imageSliderViewHConstraints)

        let imageSliderViewVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[imageSliderView]-0-|",
                                                                                      options: [],
                                                                                      metrics: nil,
                                                                                      views: ["imageSliderView": imageSliderView])
        view.addConstraints(imageSliderViewVConstraints)
        view.contentMode = .scaleToFill
        imageSliderView.contentMode = .scaleToFill
    }

    open func setDisplayLabelConstraints() {
        let constraint = NSLayoutConstraint(item: pageControl,
                                            attribute: NSLayoutConstraint.Attribute.centerX,
                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                            toItem: view,
                                            attribute: NSLayoutConstraint.Attribute.centerX,
                                            multiplier: 1.0,
                                            constant: 0.0)
        view.addConstraint(constraint)

        let displayLabelVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[pageControl]-20-|",
                                                                                      options: [],
                                                                                      metrics: nil,
                                                        views: ["pageControl": pageControl])
        view.addConstraints(displayLabelVConstraints)
    }

    open func imageSliderViewSingleTap(_ tap: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    open func imageSliderViewImageSwitch(_ index: Int, count: Int, imageUrl: String?) {
        pageControl.numberOfPages = count
        pageControl.currentPage = index
    }
}
