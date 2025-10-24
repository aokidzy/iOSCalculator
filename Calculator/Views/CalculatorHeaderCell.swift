import UIKit

class CalculatorHeaderCell: UICollectionReusableView {
    static let identifier = "CalculatorHeaderCell"
    
    // MARK: - UI Components
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(currentCalculatorText: String) {
        label.text = currentCalculatorText
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .black
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            label.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor)
        ])
    }
}
