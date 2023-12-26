import UIKit
import SnapKit

class PagingView: UIView, UIScrollViewDelegate {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(scrollView)
        addSubview(pageControl)

        scrollView.delegate = self
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        for i in 0..<3 {
            let pageView = UIImageView()
            pageView.image = [UIImage(named: "ham3"), UIImage(named: "ham2"), UIImage(named: "ham1")][i]
            pageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(pageView)

            pageView.snp.makeConstraints {
                $0.top.equalTo(scrollView.snp.top)
                $0.width.equalTo(self.snp.width)
                $0.height.equalTo(scrollView.snp.height)
                $0.leading.equalTo(scrollView.snp.leading).offset(200 * CGFloat(i))
            }
        }

        scrollView.contentSize = CGSize(width: 200 * 3, height: frame.height)
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(20)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)

        pageControl.currentPage = currentPage
    }
}
