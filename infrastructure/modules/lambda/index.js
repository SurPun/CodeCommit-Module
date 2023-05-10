const AWS = require("aws-sdk");
const codepipeline = new AWS.CodePipeline();

exports.handler = async (event) => {
  const pipelineName = "MyRepo-pipeline"

  try {
    await codepipeline.deletePipeline({ name: pipelineName }).promise();
    console.log(`Successfully deleted pipeline: \${pipelineName}`);
  } catch (error) {
    console.error(`Error deleting pipeline: \${pipelineName}`, error);
    throw error;
  }
};
