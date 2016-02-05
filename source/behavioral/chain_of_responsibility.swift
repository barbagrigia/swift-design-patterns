class Casset {
	private var banknote: Int
	private var amount : Int
		
	init (banknote: Int, amount: Int) {
		self.banknote = banknote
		self.amount = amount
	}
}
class Atm {
	private var cassets : [Casset ] = [ ]
	private var cash : [Int:Int] = [:]
	private var banknotes : [Int:Int] = [:]
	private var isCanWithdraw: Bool = false
		
	init (cassets: [Casset]) {
		self.cassets = cassets
		for casset in self.cassets {
			cash[casset.banknote] = cash[casset.banknote] == nil ? casset.amount : cash[casset.banknote]! + casset.amount
		}
	}
		
	internal func setCasset(casset: Casset) {
		for existedCasset in self.cassets {
			if existedCasset.banknote == casset.banknote {
				return existedCasset.amount = casset.amount
			}
		}
		
		cassets.append(casset)
	}

	internal func withdrawCash(sum: Int) -&gt; Bool {
		isCanWithdraw = false
		recursion(sum, level: 0, keys: cash.keys.sort({ (a, b) -&gt; Bool in a &gt; b }))
		if isCanWithdraw == true {
			// TODO: iterate over cassets, reduce the amount of the relevant banknotes, if casset is empty - disconnect it. Recalculate variable cash.
		}

		return isCanWithdraw
	}
		
	private func recursion(sum: Int, level: Int, keys: [Int]) {
		let key = keys[level]
		let count = Int(floor(Double(sum) / Double(key)))
		if count != 0 {
			banknotes[key] = count
		}
	
		let left = sum - key * count
		if left == 0 {
			isCanWithdraw = true
		} else if level + 1 &lt; keys.count {
			recursion(left, level: level + 1, keys: keys)
		}
	}
}

let atm = Atm(cassets: [
Casset(banknote: 1000, amount: 10),
Casset(banknote: 5000, amount: 10),
Casset(banknote: 100 , amount: 10),
Casset(banknote: 500 , amount: 10),
Casset(banknote: 10 , amount: 5 ),
Casset(banknote: 10 , amount: 5 ),
Casset(banknote: 50 , amount: 10)]) // The order of the cassettes is not important. Maybe more than one cassette from the same type of banknote.

atm.setCasset(Casset(banknote: 10, amount: 10))
atm.withdrawCash(11010)
atm.withdrawCash(11011)
