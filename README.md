
# GitHub Workflow Duration Calculator

This GitHub Action calculates the total time taken from the start of the workflow to a specified step. The calculated duration can be used to notify different providers, such as **Slack** and **WhatsApp**, to help developers and clients improve their actions or codebase.

## Use Cases

- Notify team members about the workflow duration.
- Monitor and optimize workflow performance.
- Provide insights into workflow efficiency.

## Input Variables

| Parameter       | Required/Optional | Description                                                                 |
|-----------------|-------------------|-----------------------------------------------------------------------------|
| `GITHUB_TOKEN`  | Required          | This token is provided by GitHub. Use `${{secrets.GITHUB_TOKEN}}`.           |
| `id`            | Required          | A unique identifier for the duration calculation. For example, use `duration`.|

## Usage

Create a file named `workflow.yml` in the `.github/workflows` folder.

```yaml
name: The name of your workflow
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Calculate Steps Log Time
        id: duration
        uses: RockyIsHere/actions-calculate-log-time@v0.2.4
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Print Calculated Time
        run: |
          echo "Calculated Time: ${{ steps.duration.outputs.duration }}"
```

## Example Workflow

This example demonstrates a complete workflow that calculates the duration and prints it:

```yaml
name: CI Pipeline
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

      - name: Calculate Steps Log Time
        id: duration
        uses: RockyIsHere/actions-calculate-log-time@v0.2.2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Print Calculated Time
        run: |
          echo "Calculated Time: ${{ steps.duration.outputs.duration }}"
```

In this example, the workflow performs the following steps:

1. Checks out the code.
2. Sets up Node.js.
3. Installs dependencies.
4. Runs tests.
5. Calculates the time taken for the steps.
6. Prints the calculated time.

This setup helps in monitoring the workflow duration and can be integrated with notification systems for better visibility and performance tracking.
