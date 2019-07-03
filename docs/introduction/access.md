## Getting access to \env{SYSTEM_NAME}

\if{LDAP_LOGIN_SUPPORT}
### Login using CSC account

In order to use the \env{SYSTEM_NAME} container cloud with a CSC account, you
will need:

1. A CSC user account
2. A computing project with rights to use \env{SYSTEM_NAME}

If you already have access to some other CSC computing system like cPouta, Sisu
or Taito then you already have a computing project. You can use the same project
with \env{SYSTEM_NAME} as well if you want.
\endif

\if{SUI_INTEGRATION_DONE}
#### Applying for access

You can apply for \env{SYSTEM_NAME} access for a computing project in the
My CSC customer portal:

1. Login to [My CSC](https://my.csc.fi) with your CSC account.
2. Go to the [My Projects](https://my.csc.fi/myProjects) page.
3. Select the project for which you want \env{SYSTEM_NAME} from the
   projects list.
4. From the list of CSC services, click on \env{SYSTEM_NAME}'s dropdown menu.
4. Read and accept the *Terms of Use* and press *Apply for access*.
5. CSC will contact you once your application has been accepted.


In case you don't already have computing project, you can create a new one using 
the My CSC customer portal and use it to apply for \env{SYSTEM_NAME} access.

#### Creating a new computing project

The My CSC customer portal makes it possible to create a new computing project:

1. Login to [My CSC](https://my.csc.fi) with your CSC account.
2. Go to the [My Projects](https://my.csc.fi/myProjects) page.
3. Scroll to the bottom of the page and click on the
[Create a new project](https://my.csc.fi/myProjects/create-project) button.
4. Give your project a desired name, description, project type and click
on *Create project*.
5. CSC will contact you once your project has been successfully created.

Please contact [rahti-support@csc.fi](mailto:rahti-support@csc.fi) in case you
need assistance.
\endif

\if{GITLAB_LOGIN_SUPPORT}
### Login using GitLab credentials

1. Select "gitlab.csc.fi" from the list of login options on \env{OSO_WEB_UI_URL}
2. If you were not already logged in to gitlab.csc.fi, click the "CSC SSO"
   button and login with your Haka credentials
3. If you are asked to authorize access, click "Authorize"
\endif
