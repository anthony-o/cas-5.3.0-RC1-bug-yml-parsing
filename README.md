# Bug report on CAS 5.3.0-RC1
In your IDE, import this project & put a breakpoint on `~/.m2/repository/org/apereo/cas/cas-server-core-api-util/5.3.0-RC1/cas-server-core-api-util-5.3.0-RC1-sources.jar!/org/apereo/cas/CipherExecutor.java:55` with condition `value instanceof Integer`.

Run `USER_ID=$(id -u) docker-compose up` and when you see `Listening for transport dt_socket at address: 5005`, launch your IDE remote Java debugger on port `5005`.

You will be stopped at the breakpoint with `key` = `"server.port"` and `value` = `8444` (instance of `Integer`).
If you step next, you will be able to retrieve the following exception:

```
java.lang.ClassCastException: java.lang.Integer cannot be cast to java.lang.String
	at org.apereo.cas.configuration.support.CasConfigurationJasyptCipherExecutor.decode(CasConfigurationJasyptCipherExecutor.java:20)
	at org.apereo.cas.CipherExecutor.lambda$decode$0(CipherExecutor.java:55)
	at java.util.Hashtable.forEach(Hashtable.java:879)
	at org.apereo.cas.CipherExecutor.decode(CipherExecutor.java:53)
	at org.apereo.cas.configuration.DefaultCasConfigurationPropertiesSourceLocator.decryptProperties(DefaultCasConfigurationPropertiesSourceLocator.java:140)
	at org.apereo.cas.configuration.DefaultCasConfigurationPropertiesSourceLocator.lambda$loadSettingsByApplicationProfiles$0(DefaultCasConfigurationPropertiesSourceLocator.java:105)
	at org.jooq.lambda.Unchecked.lambda$consumer$16(Unchecked.java:646)
	at java.util.ArrayList.forEach(ArrayList.java:1255)
	at org.apereo.cas.configuration.DefaultCasConfigurationPropertiesSourceLocator.loadSettingsByApplicationProfiles(DefaultCasConfigurationPropertiesSourceLocator.java:100)
	at org.apereo.cas.configuration.DefaultCasConfigurationPropertiesSourceLocator.locate(DefaultCasConfigurationPropertiesSourceLocator.java:63)
	at org.apereo.cas.configuration.config.CasCoreBootstrapStandaloneConfiguration.locate(CasCoreBootstrapStandaloneConfiguration.java:54)
	at org.springframework.cloud.bootstrap.config.PropertySourceBootstrapConfiguration.initialize(PropertySourceBootstrapConfiguration.java:93)
	at org.springframework.boot.SpringApplication.applyInitializers(SpringApplication.java:567)
	at org.springframework.boot.SpringApplication.prepareContext(SpringApplication.java:338)
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:301)
	at org.springframework.boot.builder.SpringApplicationBuilder.run(SpringApplicationBuilder.java:134)
	at org.apereo.cas.web.CasWebApplication.main(CasWebApplication.java:73)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.springframework.boot.loader.MainMethodRunner.run(MainMethodRunner.java:48)
	at org.springframework.boot.loader.Launcher.launch(Launcher.java:87)
	at org.springframework.boot.loader.Launcher.launch(Launcher.java:50)
	at org.springframework.boot.loader.WarLauncher.main(WarLauncher.java:59)

```

The same happened with `Boolean` values defined in `application.yml`.

An other big problem is that no log can be found explicitely, you must use an IDE to get the stacktrace...
