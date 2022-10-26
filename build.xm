<project name="SampleBuild" default="war" basedir=".">
    <taskdef resource="com/puppycrawl/tools/checkstyle/ant/checkstyle-ant-task.properties"
         classpath="WebContent/WEB-INF/lib/checkstyle-7.8.2-all.jar"/>
	<path id="compile.classpath">
        <fileset dir="WebContent/WEB-INF/lib">
            <include name="*.jar"/>
        </fileset>
    </path>
    <target name="init">
        <mkdir dir="build/classes"/>
        <mkdir dir="dist"/>
    </target>
    <target name="compile" depends="init">
        <javac srcdir="src" debug="true" destdir="build/classes">
            <classpath refid="compile.classpath"/>
        </javac>
    </target>
    <target name="checkstyle">
        <checkstyle config="sun_checks.xml" failOnViolation="false"> 
            <fileset dir="src/example" includes="**/*.java"/>
            <formatter type="xml" toFile="checkstyle_errors.xml"/>
        </checkstyle>
    </target>
    <target name="junit" depends="compile">
        <junit printsummary="yes" haltonfailure="yes">
              <classpath>
                <pathelement location="build/classes"/>
                <pathelement path="WebContent/WEB-INF/lib/junit.jar"/>
                <pathelement path="WebContent/WEB-INF/lib/org.hamcrest.core_1.3.0.v201303031735.jar"/>
              </classpath>
              <test name="junit.TestCalculator" haltonfailure="no" outfile="TestCalculator_JUnitResult">
                <formatter type="xml"/>
              </test>
        </junit>
    </target>
	<target name="war" depends="compile">
        <war destfile="dest/webapp.war" webxml="WebContent/WEB-INF/web.xml">
            <fileset dir="WebContent"/>
            <lib dir="WebContent/WEB-INF/lib"/>
            <classes dir="build/classes"/>
        </war>
    </target>

</project>
