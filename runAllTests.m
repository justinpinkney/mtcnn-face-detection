function runAllTests()
    import matlab.unittest.*
    import matlab.unittest.plugins.*
    import matlab.unittest.plugins.codecoverage.*

    try
        % Add folders to path
        install();

        % Assemble test quite
        suite = TestSuite.fromPackage('tests', 'IncludingSubpackages', true);
        runner = TestRunner.withTextOutput;

        % Add tests reults publish plugin
        xmlFile = 'testResults.xml';
        p = XMLPlugin.producingJUnitFormat(xmlFile);
        runner.addPlugin(p)

        % Add code coverage
        p = CodeCoveragePlugin.forPackage('mtcnn',...
            'IncludingSubPackages', true,...
            'Producing', CoberturaFormat('codeCoverage.xml'));   
        runner.addPlugin(p);

        % run the tests
        runner.run(suite);
       
        % exit with success
        exit(0);
    
    catch err
        % If there is an error then print report and exit
        err.getReport
        exit(1);
    end
end
