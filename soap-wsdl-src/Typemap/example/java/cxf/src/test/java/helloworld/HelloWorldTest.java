package helloworld;
import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

// Spring JUnit Test runner
@RunWith(SpringJUnit4ClassRunner.class)

// load spring context from here
@ContextConfiguration(locations = { "classpath:test-context.xml"})

/** Test class for the HelloWorld service
 *
 * It's more of a integration test, not a Unit test (though using
 * JUnit4).
 *
 * Fire up the SOAP server in example/server/hello_simple.pl before
 * running - the test will fail if it can't find the appropriate SOAP server
 * at http://localhost:8081/
 *
 */
public class HelloWorldTest {

	// soapClient bean automatically provided by spring
	@Autowired
	private Service1Soap soapClient;

	@Test
	public void testClient() {
		assertNotNull(soapClient);
		String result = soapClient.sayHello("Kutter", "Martin");
		assertEquals("Hello Martin Kutter", result);
	}
}
