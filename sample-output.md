# Code Contributed by Paul Tan
## .classpath
```
18		<classpathentry kind="src" path="src/test/resources">
23		<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.8"/>
```
## .gitignore
```
```
## .project
```
```
## .travis.yml
```
5	
6	script: >-
7	    ./config/travis/run-checks.sh &&
16	
```
## LICENSE
```
```
## README.md
```
```
## _config.yml
```
```
## appveyor.yml
```
1	# AppVeyor configuration file
2	# For more details see https://www.appveyor.com/docs/build-configuration/
3	
4	# Call on gradle to build and run tests
5	# --no-daemon: Prevent the daemon from launching to prevent file-in-use errors
6	#     when we cache the ~/.gradle directory
7	build_script:
8	    - gradlew.bat --no-daemon assemble checkstyleMain checkstyleTest
9	
10	test_script:
11	    - appveyor-retry gradlew.bat --no-daemon headless allTests
12	
13	environment:
14	    JAVA_HOME: C:\Program Files\Java\jdk1.8.0  # Use 64-bit Java
15	
16	# Files/folders to preserve between builds to speed them up
17	cache:
18	    - C:\Users\appveyor\.gradle
```
## build.gradle
```
12	    id 'application'
15	// Specifies the entry point of the application
16	mainClassName = 'seedu.address.MainApp'
17	
```
## config/checkstyle/checkstyle.xml
```
17	  <module name="NewlineAtEndOfFile">
18	    <!-- Accept LF, CR or CRLF to accomodate devs who prefer different line endings -->
19	    <property name="lineSeparator" value="lf_cr_crlf"/>
20	  </module>
287	        EQUAL, GE, GT, LAND, LCURLY, LE, LITERAL_CATCH, LITERAL_DO, LITERAL_ELSE,
291	        RCURLY, SL, SLIST, SL_ASSIGN, SR_ASSIGN, STAR, STAR_ASSIGN"/>
292	      <!-- Allow empty constructors e.g. MyClass() {} -->
293	      <property name="allowEmptyConstructors" value="true" />
294	      <!-- Allow empty methods e.g. void func() {} -->
295	      <property name="allowEmptyMethods" value="true" />
296	      <!-- Allow empty types e.g. class Foo {}, enum Foo {} -->
297	      <property name="allowEmptyTypes" value="true" />
298	      <!-- Allow empty loops e.g. for (int i = 1; i > 1; i++) {} -->
299	      <property name="allowEmptyLoops" value="true" />
300	      <!-- Allow empty lambdas e.g. () -> {} -->
301	      <property name="allowEmptyLambdas" value="true" />
318	    <!-- No trailing whitespace -->
319	    <module name="Regexp">
320	      <property name="format" value="[ \t]+$"/>
321	      <property name="illegalPattern" value="true"/>
322	      <property name="message" value="Trailing whitespace"/>
323	    </module>
324	
```
## config/travis/check-eof-newline.sh
```
1	#!/bin/sh
2	# Checks that all text files end with a newline.
3	
4	ret=0
5	
10	        ret=1
11	    fi
12	done
13	
14	exit $ret
```
## config/travis/check-line-endings.sh
```
1	#!/bin/sh
2	# Checks for prohibited line endings.
3	# Prohibited line endings: \r\n
4	
5	git grep --cached -I -n --no-color -P '\r$' -- ':/' |
6	awk '
7	    BEGIN {
8	        FS = ":"
9	        OFS = ":"
10	        ret = 0
11	    }
12	    {
13	        ret = 1
14	        print "ERROR", $1, $2, " prohibited \\r\\n line ending, use \\n instead."
15	    }
16	    END {
17	        exit ret
18	    }
19	'
```
## config/travis/check-trailing-whitespace.sh
```
1	#!/bin/sh
2	# Checks for trailing whitespace
3	
4	git grep --cached -I -n --no-color -P '[ \t]+$' -- ':/' |
5	awk '
6	    BEGIN {
7	        FS = ":"
8	        OFS = ":"
9	        ret = 0
10	    }
11	    {
12	        # Only warn for markdown files (*.md) to accomodate text editors
13	        # which do not properly handle trailing whitespace.
14	        # (e.g. GitHub web editor)
15	        if ($1 ~ /\.md$/) {
16	            severity = "WARN"
17	        } else {
18	            severity = "ERROR"
19	            ret = 1
20	        }
21	        print severity, $1, $2, " trailing whitespace."
22	    }
23	    END {
24	        exit ret
25	    }
26	'
```
## config/travis/deploy_github_pages.sh
```
```
## config/travis/run-checks.sh
```
1	#!/bin/sh
2	# Runs all check-* scripts, and returns a non-zero exit code if any of them fail.
3	
4	dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd) &&
5	ret=0 &&
6	for checkscript in "$dir"/check-*; do
7	    if ! "$checkscript"; then
8	        ret=1
9	    fi
10	done
11	exit $ret
```
## copyright.txt
```
```
## docs/AboutUs.md
```
```
## docs/ContactUs.md
```
```
## docs/DeveloperGuide.adoc
```
```
## docs/LearningOutcomes.md
```
```
## docs/TestDocument.adoc
```
```
## docs/UserGuide.adoc
```
```
## docs/UsingAppVeyor.md
```
1	# AppVeyor
2	
3	[AppVeyor](https://www.appveyor.com/) is a _Continuous Integration_ platform for GitHub projects.
4	It runs its builds on Windows virtual machines.
5	
6	AppVeyor can run the project's tests automatically whenever new code is pushed to the repo.
7	This ensures that existing functionality and features have not been broken on Windows by the changes.
8	
9	The current AppVeyor setup performs the following things whenever someone pushes code to the repo:
10	
11	* Runs the `gradlew.bat headless allTests` command.
12	
13	* Automatically retries the build up to 3 times if a task fails.
14	
15	If you would like to customize your AppVeyor build further, you can learn more about AppVeyor from the
16	[AppVeyor Documentation](https://www.appveyor.com/docs/).
17	
18	## Setting up AppVeyor
19	
20	1. Fork the repo to your own organization.
21	
22	2. Go to https://ci.appveyor.com/, and under `Login`, click on `GitHub` to login with your GitHub account.
23	   Enter your GitHub account details if needed.
24	
25	    ![Click on GitHub in the login page](images/appveyor/login.png)
26	
27	3. After logging in, you will be brought to your projects dashboard. Click on `NEW PROJECT`.
28	
29	    ![Click on "NEW PROJECT" in the projects dashboard](images/appveyor/add-project-1.png)
30	
31	4. You will be brought to the `Select repository` page. Select `GitHub`.
32	
33	    * On your first usage of AppVeyor, you will need to give AppVeyor authorization to your GitHub account.
34	      Click on `Authorize GitHub`.
35	
36	        ![Click on Authorize GitHub](images/appveyor/add-project-2.png)
37	
38	    * This will bring you to a GitHub page that manages the access of third-party applications to your repositories.
39	
40	        Depending on whether you are the owner of the repository, you can either grant access:
41	
42	        ![Grant Access](images/grant_access.png)
43	
44	        Or request access:
45	
46	        ![Request Access](images/request_access.png)
47	
48	5. AppVeyor will then list the repositories you have access to in your GitHub account.
49	   Find the repository you want to set AppVeyor up on, and then click `ADD`.
50	
51	    ![Click "Add" on the repository you want to set AppVeyor up on](images/appveyor/add-project-3.png)
52	
53	6. AppVeyor will then be activated on that repository.
54	   To see the CI in action, push a commit to any branch!
55	
56	    * Go to the repository and see the pushed commit. There should be an icon which will link you to the AppVeyor build:
57	
58	        ![Commit build](images/appveyor/ci-pending.png)
59	
60	    * As the build is run on a remote machine, we can only examine the logs it produces:
61	
62	        ![AppVeyor build](images/appveyor/ci-log.png)
63	
64	7. Update the link to the "build status" badge at the top of `README.md` to point to the AppVeyor build status of your own repo.
65	
66	    * To find your build status badge URL,
67	      first go to your project settings by clicking on the "Settings" icon:
68	
69	        ![Click on project settings](images/appveyor/project-settings-1.png)
70	
71	    * Then go to the `Badges` section of your project settings by clicking on it:
72	
73	        ![Click on "Badges"](images/appveyor/project-settings-2.png)
74	
75	    * Then copy and paste the markdown code for your `master` branch to your `README.md` file:
76	
77	        ![Copy and paste the markdown code for your `master` branch to your `README.md` file](images/appveyor/project-settings-3.png)
```
## docs/UsingGithubPages.md
```
```
## docs/UsingGradle.md
```
55	## Running the application
56	
57	* **`run`** <br>
58	  Builds and runs the application.
59	
60	* **`runShadow`** <br>
61	  Builds the application as a fat JAR, and then runs it.
62	
```
## docs/UsingTravis.md
```
9	
13	  * Runs additional [repository-wide checks](#repository-wide-checks).
50	
51	## Repository-wide checks
52	
53	In addition to running Gradle checks, we also configure Travis CI to run some repository-wide checks.
54	Unlike the Gradle checks which only cover files used in the build process,
55	these repository-wide checks cover *all* files in the repository.
56	They check for repository rules which are hard to enforce on development machines such as
57	line ending requirements.
58	
59	These checks are implemented as POSIX shell scripts,
60	and thus can only be run on POSIX-compliant operating systems such as macOS and Linux.
61	To run all checks locally on these operating systems,
62	execute the following in the repository root directory:
63	```shell
64	./config/travis/run-checks.sh
65	```
66	Any warnings or errors will be printed out to the console.
67	
68	### Implementing new checks
69	
70	Checks are implemented as executable `check-*` scripts within the `config/travis/` directory.
71	The `run-checks.sh` script will automatically pick up and run files named as such.
72	
73	Check scripts should print out errors in the following format:
74	```
75	SEVERITY:FILENAME:LINE: MESSAGE
76	```
77	where `SEVERITY` is either `ERROR` or `WARN`,
78	`FILENAME` is the path to the file relative to the current directory,
79	`LINE` is the line of the file where the error occurred
80	and `MESSAGE` is the message explaining the error.
81	
82	Check scripts must exit with a non-zero exit code if any errors occur.
```
## docs/stylesheets/asciidoctor.css
```
```
## docs/stylesheets/gh-pages.css
```
```
## gradle.properties
```
```
## gradle/wrapper/gradle-wrapper.properties
```
```
## gradlew
```
```
## gradlew.bat
```
```
## src/main/java/seedu/address/MainApp.java
```
```
## src/main/java/seedu/address/commons/core/ComponentManager.java
```
```
## src/main/java/seedu/address/commons/core/Config.java
```
```
## src/main/java/seedu/address/commons/core/EventsCenter.java
```
```
## src/main/java/seedu/address/commons/core/GuiSettings.java
```
```
## src/main/java/seedu/address/commons/core/LogsCenter.java
```
```
## src/main/java/seedu/address/commons/core/Messages.java
```
```
## src/main/java/seedu/address/commons/core/UnmodifiableObservableList.java
```
```
## src/main/java/seedu/address/commons/core/Version.java
```
```
## src/main/java/seedu/address/commons/events/BaseEvent.java
```
```
## src/main/java/seedu/address/commons/events/model/AddressBookChangedEvent.java
```
```
## src/main/java/seedu/address/commons/events/storage/DataSavingExceptionEvent.java
```
```
## src/main/java/seedu/address/commons/events/ui/ExitAppRequestEvent.java
```
```
## src/main/java/seedu/address/commons/events/ui/JumpToListRequestEvent.java
```
```
## src/main/java/seedu/address/commons/events/ui/NewResultAvailableEvent.java
```
```
## src/main/java/seedu/address/commons/events/ui/PersonPanelSelectionChangedEvent.java
```
```
## src/main/java/seedu/address/commons/events/ui/ShowHelpRequestEvent.java
```
```
## src/main/java/seedu/address/commons/exceptions/DataConversionException.java
```
```
## src/main/java/seedu/address/commons/exceptions/DuplicateDataException.java
```
```
## src/main/java/seedu/address/commons/exceptions/IllegalValueException.java
```
```
## src/main/java/seedu/address/commons/util/AppUtil.java
```
```
## src/main/java/seedu/address/commons/util/CollectionUtil.java
```
```
## src/main/java/seedu/address/commons/util/ConfigUtil.java
```
```
## src/main/java/seedu/address/commons/util/FileUtil.java
```
```
## src/main/java/seedu/address/commons/util/FxViewUtil.java
```
3	import javafx.stage.Stage;
12	     * @param iconSource e.g. {@code "/images/help_icon.png"}
13	     */
14	    public static void setStageIcon(Stage stage, String iconSource) {
15	        stage.getIcons().setAll(AppUtil.getImage(iconSource));
16	    }
17	
```
## src/main/java/seedu/address/commons/util/IndexUtil.java
```
```
## src/main/java/seedu/address/commons/util/JsonUtil.java
```
```
## src/main/java/seedu/address/commons/util/StringUtil.java
```
```
## src/main/java/seedu/address/commons/util/XmlUtil.java
```
```
## src/main/java/seedu/address/logic/Logic.java
```
```
## src/main/java/seedu/address/logic/LogicManager.java
```
```
## src/main/java/seedu/address/logic/commands/AddCommand.java
```
```
## src/main/java/seedu/address/logic/commands/ClearCommand.java
```
17	        model.resetData(new AddressBook());
```
## src/main/java/seedu/address/logic/commands/Command.java
```
```
## src/main/java/seedu/address/logic/commands/CommandResult.java
```
```
## src/main/java/seedu/address/logic/commands/DeleteCommand.java
```
```
## src/main/java/seedu/address/logic/commands/EditCommand.java
```
```
## src/main/java/seedu/address/logic/commands/ExitCommand.java
```
```
## src/main/java/seedu/address/logic/commands/FindCommand.java
```
```
## src/main/java/seedu/address/logic/commands/HelpCommand.java
```
```
## src/main/java/seedu/address/logic/commands/IncorrectCommand.java
```
```
## src/main/java/seedu/address/logic/commands/ListCommand.java
```
```
## src/main/java/seedu/address/logic/commands/SelectCommand.java
```
```
## src/main/java/seedu/address/logic/commands/exceptions/CommandException.java
```
```
## src/main/java/seedu/address/logic/parser/AddCommandParser.java
```
```
## src/main/java/seedu/address/logic/parser/ArgumentMultimap.java
```
```
## src/main/java/seedu/address/logic/parser/ArgumentTokenizer.java
```
```
## src/main/java/seedu/address/logic/parser/CliSyntax.java
```
```
## src/main/java/seedu/address/logic/parser/DeleteCommandParser.java
```
```
## src/main/java/seedu/address/logic/parser/EditCommandParser.java
```
```
## src/main/java/seedu/address/logic/parser/FindCommandParser.java
```
```
## src/main/java/seedu/address/logic/parser/Parser.java
```
```
## src/main/java/seedu/address/logic/parser/ParserUtil.java
```
```
## src/main/java/seedu/address/logic/parser/Prefix.java
```
```
## src/main/java/seedu/address/logic/parser/SelectCommandParser.java
```
```
## src/main/java/seedu/address/model/AddressBook.java
```
11	import javafx.collections.ObservableList;
47	        this();
48	        resetData(toBeCopied);
53	    public void setPersons(List<? extends ReadOnlyPerson> persons)
54	            throws UniquePersonList.DuplicatePersonException {
58	    public void setTags(Collection<Tag> tags) throws UniqueTagList.DuplicateTagException {
63	        assert newData != null;
64	        try {
65	            setPersons(newData.getPersonList());
66	        } catch (UniquePersonList.DuplicatePersonException e) {
67	            assert false : "AddressBooks should not have duplicate persons";
68	        }
69	        try {
70	            setTags(newData.getTagList());
71	        } catch (UniqueTagList.DuplicateTagException e) {
72	            assert false : "AddressBooks should not have duplicate tags";
73	        }
103	            throws UniquePersonList.DuplicatePersonException {
167	    public ObservableList<ReadOnlyPerson> getPersonList() {
172	    public ObservableList<Tag> getTagList() {
173	        return new UnmodifiableObservableList<>(tags.asObservableList());
```
## src/main/java/seedu/address/model/Model.java
```
```
## src/main/java/seedu/address/model/ModelManager.java
```
25	    private final FilteredList<ReadOnlyPerson> filteredPersons;
28	     * Initializes a ModelManager with the given addressBook and userPrefs.
30	    public ModelManager(ReadOnlyAddressBook addressBook, UserPrefs userPrefs) {
32	        assert !CollectionUtil.isAnyNull(addressBook, userPrefs);
34	        logger.fine("Initializing with address book: " + addressBook + " and user prefs " + userPrefs);
36	        this.addressBook = new AddressBook(addressBook);
37	        filteredPersons = new FilteredList<>(this.addressBook.getPersonList());
```
## src/main/java/seedu/address/model/ReadOnlyAddressBook.java
```
4	import javafx.collections.ObservableList;
14	     * Returns an unmodifiable view of the persons list.
15	     * This list will not contain any duplicate persons.
17	    ObservableList<ReadOnlyPerson> getPersonList();
20	     * Returns an unmodifiable view of the tags list.
21	     * This list will not contain any duplicate tags.
23	    ObservableList<Tag> getTagList();
```
## src/main/java/seedu/address/model/UserPrefs.java
```
```
## src/main/java/seedu/address/model/person/Address.java
```
```
## src/main/java/seedu/address/model/person/Email.java
```
```
## src/main/java/seedu/address/model/person/Name.java
```
```
## src/main/java/seedu/address/model/person/Person.java
```
```
## src/main/java/seedu/address/model/person/Phone.java
```
```
## src/main/java/seedu/address/model/person/ReadOnlyPerson.java
```
```
## src/main/java/seedu/address/model/person/UniquePersonList.java
```
85	    public void setPersons(List<? extends ReadOnlyPerson> persons) throws DuplicatePersonException {
86	        final UniquePersonList replacement = new UniquePersonList();
87	        for (final ReadOnlyPerson person : persons) {
88	            replacement.add(new Person(person));
89	        }
90	        setPersons(replacement);
91	    }
92	
```
## src/main/java/seedu/address/model/tag/Tag.java
```
```
## src/main/java/seedu/address/model/tag/UniqueTagList.java
```
69	        this();
70	        setTags(tags);
113	    public void setTags(Collection<Tag> tags) throws DuplicateTagException {
118	        internalList.setAll(tags);
121	    }
122	
```
## src/main/java/seedu/address/model/util/SampleDataUtil.java
```
```
## src/main/java/seedu/address/storage/AddressBookStorage.java
```
```
## src/main/java/seedu/address/storage/JsonUserPrefsStorage.java
```
```
## src/main/java/seedu/address/storage/Storage.java
```
```
## src/main/java/seedu/address/storage/StorageManager.java
```
```
## src/main/java/seedu/address/storage/UserPrefsStorage.java
```
```
## src/main/java/seedu/address/storage/XmlAdaptedPerson.java
```
```
## src/main/java/seedu/address/storage/XmlAdaptedTag.java
```
```
## src/main/java/seedu/address/storage/XmlAddressBookStorage.java
```
```
## src/main/java/seedu/address/storage/XmlFileStorage.java
```
```
## src/main/java/seedu/address/storage/XmlSerializableAddressBook.java
```
15	import seedu.address.model.person.Person;
49	    public ObservableList<ReadOnlyPerson> getPersonList() {
50	        final ObservableList<Person> persons = this.persons.stream().map(p -> {
58	        }).collect(Collectors.toCollection(FXCollections::observableArrayList));
59	        return new UnmodifiableObservableList<>(persons);
63	    public ObservableList<Tag> getTagList() {
64	        final ObservableList<Tag> tags = this.tags.stream().map(t -> {
72	        }).collect(Collectors.toCollection(FXCollections::observableArrayList));
73	        return new UnmodifiableObservableList<>(tags);
```
## src/main/java/seedu/address/ui/BrowserPanel.java
```
6	import javafx.fxml.FXML;
8	import javafx.scene.layout.Region;
16	public class BrowserPanel extends UiPart<Region> {
18	    private static final String FXML = "BrowserPanel.fxml";
21	    @FXML
28	        super(FXML);
33	        placeholder.getChildren().add(browser);
```
## src/main/java/seedu/address/ui/CommandBox.java
```
10	import javafx.scene.layout.Region;
17	public class CommandBox extends UiPart<Region> {
23	    private final Logic logic;
29	        super(FXML);
31	        addToPlaceholder(commandBoxPlaceholder);
```
## src/main/java/seedu/address/ui/HelpWindow.java
```
5	import javafx.fxml.FXML;
7	import javafx.scene.layout.Region;
16	public class HelpWindow extends UiPart<Region> {
25	    @FXML
26	    private WebView browser;
28	    private final Stage dialogStage;
30	    public HelpWindow() {
31	        super(FXML);
32	        Scene scene = new Scene(getRoot());
36	        FxViewUtil.setStageIcon(dialogStage, ICON);
```
## src/main/java/seedu/address/ui/MainWindow.java
```
10	import javafx.scene.layout.Region;
16	import seedu.address.commons.util.FxViewUtil;
25	public class MainWindow extends UiPart<Region> {
32	    private Stage primaryStage;
59	    public MainWindow(Stage primaryStage, Config config, UserPrefs prefs, Logic logic) {
60	        super(FXML);
63	        this.primaryStage = primaryStage;
69	        setTitle(config.getAppTitle());
73	        Scene scene = new Scene(getRoot());
82	
109	        getRoot().addEventFilter(KeyEvent.KEY_PRESSED, event -> {
118	        browserPanel = new BrowserPanel(browserPlaceholder);
119	        personListPanel = new PersonListPanel(getPersonListPlaceholder(), logic.getFilteredPersonList());
120	        new ResultDisplay(getResultDisplayPlaceholder());
122	        new CommandBox(getCommandBoxPlaceholder(), logic);
150	     * Sets the given image as the icon of the main window.
151	     * @param iconSource e.g. {@code "/images/help_icon.png"}
152	     */
153	    private void setIcon(String iconSource) {
154	        FxViewUtil.setStageIcon(primaryStage, iconSource);
155	    }
156	
157	    /**
184	        HelpWindow helpWindow = new HelpWindow();
```
## src/main/java/seedu/address/ui/PersonCard.java
```
7	import javafx.scene.layout.Region;
10	public class PersonCard extends UiPart<Region> {
37	    public PersonCard(ReadOnlyPerson person, int displayedIndex) {
38	        super(FXML);
44	        initTags(person);
47	    private void initTags(ReadOnlyPerson person) {
```
## src/main/java/seedu/address/ui/PersonListPanel.java
```
12	import javafx.scene.layout.Region;
20	public class PersonListPanel extends UiPart<Region> {
28	        super(FXML);
30	        addToPlaceholder(personListPlaceholder);
41	        placeHolderPane.getChildren().add(getRoot());
71	                setGraphic(new PersonCard(person, getIndex() + 1).getRoot());
```
## src/main/java/seedu/address/ui/ResultDisplay.java
```
12	import javafx.scene.layout.Region;
19	public class ResultDisplay extends UiPart<Region> {
30	        super(FXML);
```
## src/main/java/seedu/address/ui/StatusBarFooter.java
```
13	import javafx.scene.layout.Region;
20	public class StatusBarFooter extends UiPart<Region> {
36	
39	    @FXML
41	    @FXML
46	        super(FXML);
47	        addToPlaceholder(placeHolder);
68	        placeHolder.getChildren().add(getRoot());
```
## src/main/java/seedu/address/ui/Ui.java
```
```
## src/main/java/seedu/address/ui/UiManager.java
```
55	            mainWindow = new MainWindow(primaryStage, config, prefs, logic);
```
## src/main/java/seedu/address/ui/UiPart.java
```
3	import java.io.IOException;
4	import java.net.URL;
5	
6	import javafx.fxml.FXMLLoader;
10	import seedu.address.MainApp;
15	 * Represents a distinct part of the UI. e.g. Windows, dialogs, panels, status bars, etc.
16	 * It contains a scene graph with a root node of type {@code T}.
17	 */
18	public abstract class UiPart<T> {
19	
20	    /** Resource folder where FXML files are stored. */
21	    public static final String FXML_FILE_FOLDER = "/view/";
22	
23	    private FXMLLoader fxmlLoader;
24	
25	    /**
26	     * Constructs a UiPart with the specified FXML file URL.
27	     * The FXML file must not specify the {@code fx:controller} attribute.
28	     */
29	    public UiPart(URL fxmlFileUrl) {
30	        assert fxmlFileUrl != null;
31	        fxmlLoader = new FXMLLoader(fxmlFileUrl);
32	        fxmlLoader.setController(this);
33	        try {
34	            fxmlLoader.load();
35	        } catch (IOException e) {
36	            throw new AssertionError(e);
37	        }
38	    }
39	
40	    /**
41	     * Constructs a UiPart using the specified FXML file within {@link #FXML_FILE_FOLDER}.
42	     * @see #UiPart(URL)
43	     */
44	    public UiPart(String fxmlFileName) {
45	        this(fxmlFileName != null ? MainApp.class.getResource(FXML_FILE_FOLDER + fxmlFileName) : null);
46	    }
47	
48	    /**
49	     * Returns the root object of the scene graph of this UiPart.
51	    public T getRoot() {
52	        return fxmlLoader.getRoot();
53	    }
```
## src/main/resources/view/BrowserPanel.fxml
```
1	<?xml version="1.0" encoding="UTF-8"?>
2	
3	<?import javafx.scene.layout.AnchorPane?>
4	<?import javafx.scene.web.WebView?>
5	
6	<AnchorPane xmlns:fx="http://javafx.com/fxml/1">
7	  <WebView fx:id="browser" />
8	</AnchorPane>
```
## src/main/resources/view/CommandBox.fxml
```
```
## src/main/resources/view/DarkTheme.css
```
```
## src/main/resources/view/Extensions.css
```
```
## src/main/resources/view/HelpWindow.fxml
```
4	<?import javafx.scene.web.WebView?>
7	  <WebView fx:id="browser" />
```
## src/main/resources/view/MainWindow.fxml
```
12	<VBox xmlns="http://javafx.com/javafx/8" xmlns:fx="http://javafx.com/fxml/1">
```
## src/main/resources/view/PersonListCard.fxml
```
```
## src/main/resources/view/PersonListPanel.fxml
```
6	<VBox xmlns="http://javafx.com/javafx/8" xmlns:fx="http://javafx.com/fxml/1">
```
## src/main/resources/view/ResultDisplay.fxml
```
7	    xmlns:fx="http://javafx.com/fxml/1">
```
## src/main/resources/view/StatusBarFooter.fxml
```
3	<?import org.controlsfx.control.StatusBar?>
```
## src/main/resources/view/default.html
```
```
## src/test/data/ConfigUtilTest/EmptyConfig.json
```
```
## src/test/data/ConfigUtilTest/ExtraValuesConfig.json
```
```
## src/test/data/ConfigUtilTest/NotJsonFormatConfig.json
```
```
## src/test/data/ConfigUtilTest/TypicalConfig.json
```
```
## src/test/data/JsonUserPrefsStorageTest/EmptyUserPrefs.json
```
```
## src/test/data/JsonUserPrefsStorageTest/ExtraValuesUserPref.json
```
```
## src/test/data/JsonUserPrefsStorageTest/NotJsonFormatUserPrefs.json
```
```
## src/test/data/JsonUserPrefsStorageTest/TypicalUserPref.json
```
```
## src/test/data/XmlAddressBookStorageTest/NotXmlFormatAddressBook.xml
```
```
## src/test/data/XmlUtilTest/empty.xml
```
```
## src/test/data/XmlUtilTest/tempAddressBook.xml
```
```
## src/test/data/XmlUtilTest/validAddressBook.xml
```
```
## src/test/java/guitests/AddCommandTest.java
```
```
## src/test/java/guitests/AddressBookGuiTest.java
```
92	        AddressBook ab = new AddressBook();
```
## src/test/java/guitests/ClearCommandTest.java
```
```
## src/test/java/guitests/CommandBoxTest.java
```
```
## src/test/java/guitests/DeleteCommandTest.java
```
```
## src/test/java/guitests/EditCommandTest.java
```
```
## src/test/java/guitests/ErrorDialogGuiTest.java
```
```
## src/test/java/guitests/FindCommandTest.java
```
```
## src/test/java/guitests/GuiRobot.java
```
```
## src/test/java/guitests/HelpWindowTest.java
```
```
## src/test/java/guitests/SampleDataTest.java
```
```
## src/test/java/guitests/SelectCommandTest.java
```
```
## src/test/java/guitests/StatusBarFooterTest.java
```
```
## src/test/java/guitests/guihandles/AlertDialogHandle.java
```
```
## src/test/java/guitests/guihandles/BrowserPanelHandle.java
```
```
## src/test/java/guitests/guihandles/CommandBoxHandle.java
```
```
## src/test/java/guitests/guihandles/GuiHandle.java
```
```
## src/test/java/guitests/guihandles/HelpWindowHandle.java
```
```
## src/test/java/guitests/guihandles/MainGuiHandle.java
```
```
## src/test/java/guitests/guihandles/MainMenuHandle.java
```
```
## src/test/java/guitests/guihandles/PersonCardHandle.java
```
```
## src/test/java/guitests/guihandles/PersonListPanelHandle.java
```
```
## src/test/java/guitests/guihandles/ResultDisplayHandle.java
```
```
## src/test/java/guitests/guihandles/StatusBarFooterHandle.java
```
```
## src/test/java/seedu/address/TestApp.java
```
```
## src/test/java/seedu/address/commons/core/ConfigTest.java
```
```
## src/test/java/seedu/address/commons/core/VersionTest.java
```
```
## src/test/java/seedu/address/commons/util/AppUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/CollectionUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/ConfigUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/FileUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/IndexUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/JsonUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/StringUtilTest.java
```
```
## src/test/java/seedu/address/commons/util/XmlUtilTest.java
```
```
## src/test/java/seedu/address/logic/LogicManagerTest.java
```
```
## src/test/java/seedu/address/logic/commands/AddCommandTest.java
```
```
## src/test/java/seedu/address/logic/commands/EditCommandIntegrationTest.java
```
```
## src/test/java/seedu/address/logic/commands/EditCommandTest.java
```
```
## src/test/java/seedu/address/logic/commands/EditPersonDescriptorTest.java
```
```
## src/test/java/seedu/address/logic/parser/ArgumentTokenizerTest.java
```
```
## src/test/java/seedu/address/logic/parser/EditCommandParserTest.java
```
```
## src/test/java/seedu/address/logic/parser/ParserUtilTest.java
```
```
## src/test/java/seedu/address/model/AddressBookTest.java
```
1	package seedu.address.model;
2	
3	import static org.junit.Assert.assertEquals;
4	
7	import java.util.Collection;
8	import java.util.Collections;
9	import java.util.List;
10	
11	import org.junit.Rule;
12	import org.junit.Test;
13	import org.junit.rules.ExpectedException;
19	import seedu.address.model.tag.Tag;
21	
22	public class AddressBookTest {
23	
24	    @Rule
25	    public ExpectedException thrown = ExpectedException.none();
26	
27	    private final AddressBook addressBook = new AddressBook();
28	
29	    @Test
30	    public void constructor() {
31	        assertEquals(Collections.emptyList(), addressBook.getPersonList());
32	        assertEquals(Collections.emptyList(), addressBook.getTagList());
33	    }
34	
35	    @Test
36	    public void resetData_null_throwsAssertionError() {
37	        thrown.expect(AssertionError.class);
38	        addressBook.resetData(null);
39	    }
40	
41	    @Test
42	    public void resetData_withValidReadOnlyAddressBook_replacesData() {
44	        addressBook.resetData(newData);
45	        assertEquals(newData, addressBook);
46	    }
47	
48	    @Test
49	    public void resetData_withDuplicatePersons_throwsAssertionError() {
51	        // Repeat td.alice twice
52	        List<Person> newPersons = Arrays.asList(new Person(td.alice), new Person(td.alice));
54	        AddressBookStub newData = new AddressBookStub(newPersons, newTags);
55	
56	        thrown.expect(AssertionError.class);
57	        addressBook.resetData(newData);
58	    }
59	
60	    @Test
61	    public void resetData_withDuplicateTags_throwsAssertionError() {
63	        List<ReadOnlyPerson> newPersons = typicalAddressBook.getPersonList();
64	        List<Tag> newTags = new ArrayList<>(typicalAddressBook.getTagList());
65	        // Repeat the first tag twice
66	        newTags.add(newTags.get(0));
67	        AddressBookStub newData = new AddressBookStub(newPersons, newTags);
68	
69	        thrown.expect(AssertionError.class);
70	        addressBook.resetData(newData);
71	    }
72	
73	    /**
74	     * A stub ReadOnlyAddressBook whose persons and tags lists can violate interface constraints.
75	     */
76	    private static class AddressBookStub implements ReadOnlyAddressBook {
77	        private final ObservableList<ReadOnlyPerson> persons = FXCollections.observableArrayList();
78	        private final ObservableList<Tag> tags = FXCollections.observableArrayList();
79	
80	        AddressBookStub(Collection<? extends ReadOnlyPerson> persons, Collection<? extends Tag> tags) {
81	            this.persons.setAll(persons);
82	            this.tags.setAll(tags);
83	        }
84	
85	        @Override
86	        public ObservableList<ReadOnlyPerson> getPersonList() {
87	            return persons;
88	        }
89	
90	        @Override
91	        public ObservableList<Tag> getTagList() {
92	            return tags;
93	        }
94	    }
95	
96	}
```
## src/test/java/seedu/address/model/UnmodifiableObservableListTest.java
```
```
## src/test/java/seedu/address/model/person/AddressTest.java
```
```
## src/test/java/seedu/address/model/person/EmailTest.java
```
```
## src/test/java/seedu/address/model/person/NameTest.java
```
```
## src/test/java/seedu/address/model/person/PhoneTest.java
```
```
## src/test/java/seedu/address/storage/JsonUserPrefsStorageTest.java
```
```
## src/test/java/seedu/address/storage/StorageManagerTest.java
```
```
## src/test/java/seedu/address/storage/XmlAddressBookStorageTest.java
```
75	        original.addPerson(new Person(td.hoon));
76	        original.removePerson(new Person(td.alice));
82	        original.addPerson(new Person(td.ida));
```
## src/test/java/seedu/address/testutil/AddressBookBuilder.java
```
```
## src/test/java/seedu/address/testutil/EditCommandTestUtil.java
```
```
## src/test/java/seedu/address/testutil/EditPersonDescriptorBuilder.java
```
```
## src/test/java/seedu/address/testutil/EventsCollector.java
```
```
## src/test/java/seedu/address/testutil/PersonBuilder.java
```
```
## src/test/java/seedu/address/testutil/PersonUtil.java
```
```
## src/test/java/seedu/address/testutil/SerializableTestClass.java
```
```
## src/test/java/seedu/address/testutil/TestUtil.java
```
```
## src/test/java/seedu/address/testutil/TypicalPersons.java
```
48	                ab.addPerson(new Person(person));
53	    }
```
## src/test/java/seedu/address/ui/TestFxmlObject.java
```
1	package seedu.address.ui;
2	
3	import javafx.beans.DefaultProperty;
4	
5	/**
6	 * A test object which can be constructed via an FXML file.
7	 * Unlike other JavaFX classes, this class can be constructed without the JavaFX toolkit being initialized.
8	 */
9	@DefaultProperty("text")
10	public class TestFxmlObject {
11	
12	    private String text;
13	
14	    public TestFxmlObject() {}
15	
16	    public TestFxmlObject(String text) {
17	        setText(text);
18	    }
19	
20	    public String getText() {
21	        return text;
22	    }
23	
24	    public void setText(String text) {
25	        this.text = text;
26	    }
27	
28	    @Override
29	    public boolean equals(Object other) {
32	                        && this.text.equals(((TestFxmlObject) other).getText()));
33	    }
34	
35	}
```
## src/test/java/seedu/address/ui/UiPartTest.java
```
1	package seedu.address.ui;
2	
3	import static org.junit.Assert.assertEquals;
4	import static org.junit.Assert.assertNotNull;
5	
6	import java.net.URL;
8	import org.junit.Rule;
9	import org.junit.Test;
10	import org.junit.rules.ExpectedException;
11	import org.junit.rules.TemporaryFolder;
12	
13	import javafx.fxml.FXML;
14	import seedu.address.MainApp;
15	
16	public class UiPartTest {
17	
18	    private static final String MISSING_FILE_PATH = "UiPartTest/missingFile.fxml";
19	    private static final String INVALID_FILE_PATH = "UiPartTest/invalidFile.fxml";
20	    private static final String VALID_FILE_PATH = "UiPartTest/validFile.fxml";
21	    private static final TestFxmlObject VALID_FILE_ROOT = new TestFxmlObject("Hello World!");
22	
23	    @Rule
24	    public ExpectedException thrown = ExpectedException.none();
25	
26	    @Rule
27	    public TemporaryFolder testFolder = new TemporaryFolder();
28	
29	    @Test
30	    public void constructor_nullFileUrl_throwsAssertionError() {
31	        thrown.expect(AssertionError.class);
32	        new TestUiPart<Object>((URL) null);
33	    }
34	
35	    @Test
36	    public void constructor_missingFileUrl_throwsAssertionError() throws Exception {
37	        URL missingFileUrl = new URL(testFolder.getRoot().toURI().toURL(), MISSING_FILE_PATH);
38	        thrown.expect(AssertionError.class);
39	        new TestUiPart<Object>(missingFileUrl);
40	    }
41	
42	    @Test
43	    public void constructor_invalidFileUrl_throwsAssertionError() {
44	        URL invalidFileUrl = getTestFileUrl(INVALID_FILE_PATH);
45	        thrown.expect(AssertionError.class);
46	        new TestUiPart<Object>(invalidFileUrl);
47	    }
48	
49	    @Test
50	    public void constructor_validFileUrl_loadsFile() {
51	        URL validFileUrl = getTestFileUrl(VALID_FILE_PATH);
52	        assertEquals(VALID_FILE_ROOT, new TestUiPart<TestFxmlObject>(validFileUrl).getRoot());
53	    }
54	
55	    @Test
56	    public void constructor_nullFileName_throwsAssertionError() {
57	        thrown.expect(AssertionError.class);
58	        new TestUiPart<Object>((String) null);
59	    }
60	
61	    @Test
62	    public void constructor_missingFileName_throwsAssertionError() {
63	        thrown.expect(AssertionError.class);
64	        new TestUiPart<Object>(MISSING_FILE_PATH);
65	    }
66	
67	    @Test
68	    public void constructor_invalidFileName_throwsAssertionError() {
69	        thrown.expect(AssertionError.class);
70	        new TestUiPart<Object>(INVALID_FILE_PATH);
71	    }
72	
73	    private URL getTestFileUrl(String testFilePath) {
74	        String testFilePathInView = "/view/" + testFilePath;
75	        URL testFileUrl = MainApp.class.getResource(testFilePathInView);
76	        assertNotNull(testFilePathInView + " does not exist.", testFileUrl);
77	        return testFileUrl;
78	    }
79	
80	    /**
81	     * UiPart used for testing.
82	     * It should only be used with invalid FXML files or the valid file located at {@link VALID_FILE_PATH}.
83	     */
84	    private static class TestUiPart<T> extends UiPart<T> {
85	
86	        @FXML
87	        private TestFxmlObject validFileRoot; // Check that @FXML annotations work
88	
89	        TestUiPart(URL fxmlFileUrl) {
90	            super(fxmlFileUrl);
91	            assertEquals(VALID_FILE_ROOT, validFileRoot);
92	        }
93	
94	        TestUiPart(String fxmlFileName) {
95	            super(fxmlFileName);
96	            assertEquals(VALID_FILE_ROOT, validFileRoot);
97	        }
98	
99	    }
100	
101	}
```
## src/test/resources/view/UiPartTest/invalidFile.fxml
```
1	Not a valid FXML file
```
## src/test/resources/view/UiPartTest/validFile.fxml
```
1	<?xml version="1.0" encoding="UTF-8"?>
2	
3	<?import seedu.address.ui.TestFxmlObject?>
4	<TestFxmlObject xmlns:fx="http://javafx.com/fxml/1" fx:id="validFileRoot">Hello World!</TestFxmlObject>
```
