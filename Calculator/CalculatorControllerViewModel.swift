import Foundation

class CalculatorControllerViewModel {
    
    // MARK: - TableView DataSource Array
    let calculatorButtonCells: [CalculatorButton] = [
        .allClear, .plusMinus, .persentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .substract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    private(set) lazy var calculatorHeaderLabel: String = "42"
}
