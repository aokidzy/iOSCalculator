import UIKit

class ButtonCell: UICollectionViewCell {
    
    static let identifier = "ButtonCell"
    
    //MARK: - Variables
    private(set) var calculatorButton: CalculatorButton!
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    //MARK: - Configure
    public func configure(with calculatorButton: CalculatorButton) {
        self.calculatorButton = calculatorButton
        titleLabel.text = calculatorButton.title
        self.backgroundColor = calculatorButton.color
        
        switch calculatorButton {
        case .allClear, .plusMinus, .persentage:
            titleLabel.textColor = .black
        default:
            titleLabel.textColor = .white
        }
        
        setupUI()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switch calculatorButton {
        case .number(let int) where int == 0:
            layer.cornerRadius = 36
            
            let extraSpace = frame.width - frame.height
            NSLayoutConstraint.activate([
                titleLabel.heightAnchor.constraint(equalToConstant: frame.height),
                titleLabel.widthAnchor.constraint(equalToConstant: frame.height),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -extraSpace),
            ])
        default:
            layer.cornerRadius = self.frame.size.width/2
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
                titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.removeFromSuperview()
    }
}
