# Business Central Invoice Import Extension

This project is an AL extension for Microsoft Dynamics 365 Business Central, designed to import invoices directly from an XML file. Once imported, the invoice will be displayed in the Sales Invoices list within Business Central.

## Prerequisites

To use this extension, ensure the following are in place:

- **Windows Operating System**: Required for running Microsoft Dynamics 365 Business Central.
- **Microsoft Dynamics 365 Business Central**: Ensure Business Central is installed as outlined in the course requirements.
- **Visual Studio Code with AL Language Extension**: Install the AL Language extension in Visual Studio Code to create, edit, and deploy AL projects.

## Setup Instructions

1. **Create a New AL Project**:
   - Open Visual Studio Code and create a new AL project in your workspace.

2. **Download Symbols**:
   - To integrate with Business Central, download the necessary symbols by selecting `Ctrl+Shift+P` > `AL: Download Symbols`.
   - If symbols do not download correctly, delete the `.alpackages` folder (as it serves as cache) and attempt to download symbols again.

3. **Deploy the Extension**:
   - After setting up the project, press `F5` in Visual Studio Code to deploy and run the project on the local Business Central server.

4. **Verify Extension Installation**:
   - Open Business Central and navigate to **Extension Management**.
   - Confirm that the custom extension package appears in the list of installed extensions.

## Usage Instructions

To import and view an invoice, follow these steps:

1. In Business Central, navigate to **Sales**.
2. Go to **Sales Invoices**.
3. In the **Actions** menu, select **Import Invoice**.
4. Choose the provided `invoice.xml` file and initiate the import.
5. Proceed through any prompts by pressing **OK** until the import process is completed.
6. Once the invoice is successfully imported, it should appear in the Sales Invoices list, ready for review.

This process ensures that the invoice is correctly imported and accessible within the Sales Invoices list in Business Central.
