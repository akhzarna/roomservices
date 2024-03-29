import UIKit

class ImageSliderCell: UIView, UIScrollViewDelegate {

    var delegate: ImageSliderViewDelegate?
    let imageUrl: String

     let imageView = UIImageView()
    fileprivate let scrollView = UIScrollView()

    override var frame: CGRect {
        didSet {
            if !frame.equalTo(CGRect.zero) {
                scrollView.frame = bounds
                resetZoomScale()
                drawImage()
            }
        }
    }

    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(frame: CGRect.zero)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        self.imageUrl = ""
        super.init(coder: aDecoder)
        initialize()
    }

 open   func initialize() {

        scrollView.clipsToBounds = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
      //  scrollView.decelerationRate /= 2
        scrollView.bouncesZoom = true
        scrollView.addSubview(imageView)

    
    
        addSubview(scrollView)

//        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(imageSliderCellDoubleTap))
//        doubleTap.numberOfTapsRequired = 2
//        scrollView.addGestureRecognizer(doubleTap)
//
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageSliderCellSingleTap))
//        singleTap.numberOfTapsRequired = 1
//        singleTap.require(toFail: doubleTap)
//        scrollView.addGestureRecognizer(singleTap)
    }


    @objc func imageSliderCellDoubleTap(_ tap: UITapGestureRecognizer) {
        let touchPoint = tap.location(in: self)
        if (scrollView.zoomScale == scrollView.minimumZoomScale) {
            scrollView.zoom(to: CGRect(x: touchPoint.x, y: touchPoint.y, width: 1, height: 1), animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }

//    @objc func imageSliderCellSingleTap(_ tap: UITapGestureRecognizer) {
//        delegate?.imageSliderCellSingleTap(tap)
//    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.center = centerOfScrollView(scrollView)
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            view?.center = self.centerOfScrollView(scrollView)
        })
    }

    func loadImage() {
        if let _ = imageView.image {
            return
        }
        scrollView.frame = bounds
        resetZoomScale()
          imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "default-property"))
    }

    func resetZoomScale() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
    }

    func drawImage() {
        var scrollViewFrame = scrollView.frame
        if imageView.image == nil {
            scrollViewFrame.origin = CGPoint.zero
            imageView.frame = scrollViewFrame
            scrollView.contentSize = imageView.frame.size
            resetZoomScale()
        } else {
            let imageSize = imageView.image!.size
         //   let ratio = scrollViewFrame.size.width / imageSize.width
            imageView.frame = CGRect(x: 0, y: 0, width: scrollViewFrame.size.width, height: scrollViewFrame.size.height)
            scrollView.contentSize = imageView.frame.size
            imageView.center = centerOfScrollView(scrollView)
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = scrollViewFrame.height / imageView.frame.size.height
            scrollView.zoomScale = 1.0
        }
        scrollView.contentOffset = CGPoint.zero
    }

    func centerOfScrollView(_ scrollView: UIScrollView) -> CGPoint {
        var offsetX: CGFloat
        if scrollView.bounds.size.width > scrollView.bounds.size.height {
            offsetX = (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5
        } else {
            offsetX = 0.0
        }

        var offsetY: CGFloat
        if scrollView.bounds.size.height > scrollView.contentSize.height {
            offsetY = (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5
        } else {
            offsetY = 0.0
        }

        return CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                           y: scrollView.contentSize.height * 0.5 + offsetY)
    }
}
