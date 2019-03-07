// contracts
const Property = artifacts.require("./Property.sol");

contract('Property Contract Tests', function(accounts) {

	let property;
	const alice = accounts[0], bob = accounts[1];

	it('should be deployed, property', async () => {
		property = await Property.deployed(undefined,{from: bob});
		assert(property !== undefined, 'property was NOT deployed');
	});

	it('should let Alice invite a Bob, then Bob should be able to pay', async () => {
		try {
			const tx = await property.inviteGuest(bob, { from: alice });
			assert(true, 'Alice should be able to invite alice');
		} catch(e) {
			assert(false, 'Alice was not able to invite alice');
		}

		try {
			const tx = await property.reserveRoom({ from: bob, value: 1 });
			assert(true, 'Bob should be able to pay');
		} catch(e) {
			assert(false, 'Bob could not pay');
		}
	});

});