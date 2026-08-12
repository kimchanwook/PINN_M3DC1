function tests = test_backbone
%TEST_BACKBONE Contract tests for the MATLAB project scaffold.
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
testsDir = fileparts(mfilename('fullpath'));
matlabRoot = fileparts(testsDir);
sourceDir = fullfile(matlabRoot, 'src');
addpath(sourceDir);
testCase.TestData.sourceDir = sourceDir;
end

function teardownOnce(testCase)
rmpath(testCase.TestData.sourceDir);
end

function testRegistryIsValid(testCase)
pinn_m3dc1.common.validate_registry();
specs = pinn_m3dc1.common.registry();
verifyEqual(testCase, numel(specs), 5);
end

function testNominalOrderIsNumbered(testCase)
actual = pinn_m3dc1.common.nominal_startup_order();
expected = {'module_1', 'module_2', 'module_3', 'module_4', 'module_5'};
verifyEqual(testCase, actual, expected);
end

function testSharedStateContract(testCase)
state = pinn_m3dc1.common.ProjectState();
module = pinn_m3dc1.common.ScaffoldModule( ...
    'module_test', {}, 'test_product');
module.run(state);
verifyTrue(testCase, state.fields.test_product);
verifyEqual(testCase, state.history{end}.module, 'module_test');
end

function testMissingProductFailsLoudly(testCase)
state = pinn_m3dc1.common.ProjectState();
module = pinn_m3dc1.common.ScaffoldModule( ...
    'module_test', {'missing'}, 'unused');
verifyError(testCase, @() module.run(state), ...
    'pinn_m3dc1:MissingProducts');
end

function testAllModuleScaffoldsAreAddressable(testCase)
specs = pinn_m3dc1.common.registry();
for i = 1:numel(specs)
    factory = str2func(sprintf('pinn_m3dc1.%s.solver', specs(i).package));
    module = factory();
    verifyEqual(testCase, module.moduleId, specs(i).id);
end
end
