import UIKit

enum Actions {
    case actionA
    case doubleA
    case actionB
    case doubleB
}

protocol MedtiatorProtocol: class {
    func notify(component: BaseComponent, action: Actions)
}

class ConcreteMediator: MedtiatorProtocol {
    private var componentA: ComponentA
    private var componentB: ComponentB
    
    init(_ componentA: ComponentA, _ componentB: ComponentB) {
        self.componentA = componentA
        self.componentB = componentB
    }
    
    func notify(component: BaseComponent, action: Actions) {
        if action == .actionA {
            print("mediator check action a")
            componentB.doSomeActionDoubleB()
        } else if action == .actionB {
            print("mediator check action b")
            componentA.doSomeActionDoubleA()
        }
    }
}

class BaseComponent {
    fileprivate weak var mediator: MedtiatorProtocol?
    
    init(_ mediator: MedtiatorProtocol? = nil) {
        self.mediator = mediator
    }
    
    func update(mediator: MedtiatorProtocol) {
        self.mediator = mediator
    }
}

class ComponentA: BaseComponent {
    func doSomeActionA() {
        print("action a")
        self.mediator?.notify(component: self, action: .actionA)
    }
    
    func doSomeActionDoubleA() {
        print("double action a")
        self.mediator?.notify(component: self, action: .doubleA)
    }
}

class ComponentB: BaseComponent {
    func doSomeActionB() {
        print("action b")
        self.mediator?.notify(component: self, action: .actionB)
    }
    
    func doSomeActionDoubleB() {
        print("double action b")
        self.mediator?.notify(component: self, action: .doubleB)
    }
}


let componentA = ComponentA()
let componentB = ComponentB()

let mediator = ConcreteMediator(componentA, componentB)
componentA.update(mediator: mediator)
componentB.update(mediator: mediator)

componentA.doSomeActionA()
print("---    ---    ---   ---   ---")
componentB.doSomeActionB()
