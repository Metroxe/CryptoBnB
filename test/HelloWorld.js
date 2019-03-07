// contracts
const HelloWorld = artifacts.require("./HelloWorld.sol");

/**************************************
 * Tests
 **************************************/

contract('HelloWorld Contract Tests', function(accounts) {

	let helloWorld;
	const message = 'hello world!';
	const alice = accounts[0], bob = accounts[1];

	it('should be deployed, HelloWorld', async () => {
		helloWorld = await HelloWorld.deployed();
		assert(helloWorld !== undefined, 'HelloWorld was NOT deployed');
	});

	it('should NOT let Bob say "' + message + '"', async () => {
		try {
			const tx = await helloWorld.hello(message, { from: bob }); //say message value from Bob
			assert(false, 'Bob should not be able to say Hello, but he could');
		} catch(e) {
			assert(true, 'Bob was not allowed to say "hello"');
		}
	});

});