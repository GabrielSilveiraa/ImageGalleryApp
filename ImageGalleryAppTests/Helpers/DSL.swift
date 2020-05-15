import Quick
import Nimble

func given(_ description: String, flags: FilterFlags = [:], closure: @escaping () -> Void) {
    context("Given " + description, flags: flags, closure: closure)
}

func when(_ description: String, flags: FilterFlags = [:], closure: @escaping () -> Void) {
    describe("When " + description, flags: flags, closure: closure)
}

func then(_ description: String, flags: FilterFlags = [:], closure: @escaping () -> Void) {
    it("Then " + description, flags: flags, closure: closure)
}

func and(_ description: String, flags: FilterFlags = [:], closure: @escaping () -> Void) {
    context("And " + description, flags: flags, closure: closure)
}
