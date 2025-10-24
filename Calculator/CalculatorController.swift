import UIKit

class CalculatorController: UIViewController {
    
    //MARK: - Variables
    let viewModel: CalculatorControllerViewModel
    
    // MARK: - Layout constants
    private let numberOfColumns: CGFloat = 4
    private let interItemSpacing: CGFloat = 10
    private let lineSpacing: CGFloat = 10
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(
            CalculatorHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CalculatorHeaderCell.identifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    init(_ viewModel: CalculatorControllerViewModel = CalculatorControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.minimumInteritemSpacing = interItemSpacing
            flow.minimumLineSpacing = lineSpacing
            flow.sectionInset = sectionInsets
            flow.headerReferenceSize = .zero
        }
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.alwaysBounceVertical = false
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - CollectionView Methods
extension CalculatorController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Section Header Cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.calculatorButtonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else {
            fatalError("Failed to dequeue ButtonCell in CalculatorController")
        }
        let calculatorButton = viewModel.calculatorButtonCells[indexPath.row]
        cell.configure(with: calculatorButton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalculatorHeaderCell.identifier, for: indexPath) as? CalculatorHeaderCell else {
            fatalError("Failed to dequeue HeaderCell in CalculatorController")
        }
        header.configure(currentCalculatorText: viewModel.calculatorHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let safeAreaHeight = view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        
        let totalHorizontalInsets = sectionInsets.left + sectionInsets.right
        let totalInterItemSpacing = interItemSpacing * (numberOfColumns - 1)
        let availableWidth = view.bounds.width - totalHorizontalInsets - totalInterItemSpacing
        let baseItemWidth = floor(availableWidth / numberOfColumns)
        let baseItemHeight = baseItemWidth
        
        let rows: CGFloat = 5
        let gridHeight = sectionInsets.top + (rows * baseItemHeight) + ((rows - 1) * lineSpacing) + sectionInsets.bottom
        
        let headerHeight = max(0, safeAreaHeight - gridHeight)
        return CGSize(width: view.bounds.width, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHorizontalInsets = sectionInsets.left + sectionInsets.right
        let totalInterItemSpacing = interItemSpacing * (numberOfColumns - 1)
        let availableWidth = view.bounds.width - totalHorizontalInsets - totalInterItemSpacing
        let baseItemWidth = floor(availableWidth / numberOfColumns)
        let baseItemHeight = baseItemWidth
        
        let calculatorButton = viewModel.calculatorButtonCells[indexPath.row]
        switch calculatorButton {
        case .number(let int) where int == 0:
            let doubleWidth = (baseItemWidth * 2) + interItemSpacing
            return CGSize(width: doubleWidth, height: baseItemHeight)
        default:
            return CGSize(width: baseItemWidth, height: baseItemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = viewModel.calculatorButtonCells[indexPath.row]
        print(buttonCell.title)
    }
}
