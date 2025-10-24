import UIKit

enum CalculatorButton {
    case allClear
    case plusMinus
    case persentage
    case divide
    case multiply
    case substract
    case add
    case equals
    case number(Int)
    case decimal
    
    init(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear, .plusMinus, .persentage, .divide, .multiply, .substract, .add, .equals, .decimal:
            self = calculatorButton
        case .number(let int):
            if int.description.count == 1 {
                self = calculatorButton
            } else {
                fatalError("CalculatorButton.number Int is not 1 digit ")
            }
        }
    }
}

extension CalculatorButton {
    var title: String {
        switch self {
        case .allClear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .persentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .substract:
            return "-"
        case .add:
            return "+"
        case .equals:
            return "="
        case .number(let int):
            return int.description
        case .decimal:
            return "."
        }
    }
    
    var color: UIColor {
        switch self {
        case .allClear, .plusMinus, .persentage:
            return .lightGray
        case .divide, .multiply, .substract, .add, .equals:
            return .systemOrange
        case .number, .decimal:
            return .darkGray
        }
    }
    
    var selectedColor: UIColor? {
        switch self {
        case .allClear, .plusMinus, .persentage, .equals, .number, .decimal:
            return nil
        case .divide, .multiply, .substract, .add:
            return .white
        }
    }
}
