import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*

def credentials_for_username(String username) {
  def username_matcher = CredentialsMatchers.withUsername(username)
  def available_credentials =
      CredentialsProvider.lookupCredentials(
        StandardUsernameCredentials.class,
        Jenkins.getInstance(),
        hudson.security.ACL.SYSTEM
      )

  return CredentialsMatchers.filter(available_credentials, username_matcher)
}

list = credentials_for_username("username_HERE")
for (credentials in list) {
  store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()
  store.removeCredentials(Domain.global(), credentials)
}