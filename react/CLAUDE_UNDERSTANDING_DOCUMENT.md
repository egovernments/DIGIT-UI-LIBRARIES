# DIGIT UI Libraries - Claude Understanding Document

## Overview

DIGIT UI Libraries is a comprehensive React component library designed for building government digital services. This document provides Claude with complete understanding of the component library's structure, capabilities, and usage patterns to enable intelligent assistance across different sessions.

**Package Name:** `@egovernments/digit-ui-components`  
**Current Version:** 2.0.0-dev-01  
**React Version:** 19.0.0  
**Node Requirements:** >=18  

## Package Installation and Setup

```bash
# NPM Installation
npm install @egovernments/digit-ui-components
npm install @egovernments/digit-ui-components-css
npm install @egovernments/digit-ui-svg-components

# Yarn Installation  
yarn add @egovernments/digit-ui-components
yarn add @egovernments/digit-ui-components-css
yarn add @egovernments/digit-ui-svg-components
```

### CSS Import Required
```jsx
import '@egovernments/digit-ui-components-css/dist/index.css';
```

## Component Architecture

The library follows **Atomic Design Principles** with components organized into three tiers:

### 1. Atomic Components (77 components)
**Basic UI building blocks that cannot be broken down further**

#### Form & Input Components

##### TextInput
```jsx
import { TextInput } from '@egovernments/digit-ui-components';

<TextInput
  name="username"
  placeholder="Enter username"
  value={value}
  onChange={handleChange}
  type="text" // text|password|numeric|geolocation|date|search
  disabled={false}
  validation={{ required: true, pattern: /^[a-zA-Z]+$/ }}
  maxlength={50}
  icon="Person" // Icon name from SVG library
  iconPosition="left" // left|right
/>
```

**Key Props:**
- `name` (string): Field identifier
- `placeholder` (string): Placeholder text
- `value` (string): Input value
- `onChange` (function): Change handler
- `type` (enum): Input type variant
- `disabled` (boolean): Disabled state
- `validation` (object): Validation rules
- `maxlength` (number): Character limit
- `icon` (string): Icon name
- `iconPosition` (enum): Icon position

##### Button
```jsx
import { Button } from '@egovernments/digit-ui-components';

<Button
  label="Submit"
  variation="primary" // primary|secondary|teritiary|link
  size="medium" // large|medium|small
  onClick={handleClick}
  icon="ArrowForward"
  iconPosition="right" // left|right
  isDisabled={false}
  isLoading={false}
/>
```

**Key Props:**
- `label` (string): Button text
- `variation` (enum): Button style variant
- `size` (enum): Button size
- `onClick` (function): Click handler
- `icon` (string): Icon name
- `iconPosition` (enum): Icon position
- `isDisabled` (boolean): Disabled state
- `isLoading` (boolean): Loading state

##### CheckBox
```jsx
import { CheckBox } from '@egovernments/digit-ui-components';

<CheckBox
  label="Accept terms"
  value="terms"
  checked={isChecked}
  onChange={handleChange}
  disabled={false}
  isLabelFirst={true}
  isIntermediate={false}
/>
```

##### RadioButtons
```jsx
import { RadioButtons } from '@egovernments/digit-ui-components';

<RadioButtons
  options={[
    { code: "male", name: "Male" },
    { code: "female", name: "Female" }
  ]}
  selectedOption={selectedGender}
  onSelect={handleGenderSelect}
  optionsKey="name"
  alignVertical={true}
  disabled={false}
/>
```

##### Dropdown
```jsx
import { Dropdown } from '@egovernments/digit-ui-components';

<Dropdown
  options={cityOptions}
  selected={selectedCity}
  select={handleCitySelect}
  variant="default" // default|nesteddropdown|treedropdown
  isSearchable={true}
  placeholder="Select City"
  disabled={false}
/>
```

#### Display Components

##### Card
```jsx
import { Card, CardHeader, CardText } from '@egovernments/digit-ui-components';

<Card variant="primary" className="custom-card">
  <CardHeader>Header Content</CardHeader>
  <CardText>Body content goes here</CardText>
</Card>
```

##### AlertCard
```jsx
import { AlertCard } from '@egovernments/digit-ui-components';

<AlertCard
  type="error" // error|success|warning|info
  message="This is an error message"
  showIcon={true}
  onClose={handleClose}
/>
```

##### Toast
```jsx
import { Toast } from '@egovernments/digit-ui-components';

<Toast
  message="Operation successful"
  type="success" // success|error|warning|info
  duration={3000}
  onClose={handleClose}
/>
```

##### Chip
```jsx
import { Chip } from '@egovernments/digit-ui-components';

<Chip
  text="Active"
  className="status-chip"
  onClick={handleChipClick}
  extraStyles={{ backgroundColor: "#00703C" }}
/>
```

#### Navigation Components

##### Header
```jsx
import { Header } from '@egovernments/digit-ui-components';

<Header
  className="app-header"
  backgroundColor="#0B4B66"
  logo={{
    url: "/logo.png",
    alt: "Logo"
  }}
  rightIcon="Menu"
  onRightIconClick={handleMenuClick}
/>
```

##### BreadCrumb
```jsx
import { BreadCrumb } from '@egovernments/digit-ui-components';

<BreadCrumb
  crumbs={[
    { content: "Home", show: true },
    { content: "Dashboard", show: true },
    { content: "Profile", show: true, isLast: true }
  ]}
  className="breadcrumb-nav"
/>
```

##### Tab
```jsx
import { Tab } from '@egovernments/digit-ui-components';

<Tab
  options={[
    { key: "details", name: "Details" },
    { key: "documents", name: "Documents" }
  ]}
  selectedOption={activeTab}
  onSelect={handleTabChange}
  variant="horizontal" // horizontal|vertical
/>
```

#### Data Display Components

##### Table Components
```jsx
import { 
  TableMain, 
  TableHeader, 
  TableBody, 
  TableRow, 
  TableCell 
} from '@egovernments/digit-ui-components';

<TableMain>
  <TableHeader>
    <TableRow>
      <TableCell>Name</TableCell>
      <TableCell>Status</TableCell>
      <TableCell>Actions</TableCell>
    </TableRow>
  </TableHeader>
  <TableBody>
    <TableRow>
      <TableCell>John Doe</TableCell>
      <TableCell>Active</TableCell>
      <TableCell>
        <Button label="Edit" variation="link" />
      </TableCell>
    </TableRow>
  </TableBody>
</TableMain>
```

##### Timeline
```jsx
import { Timeline } from '@egovernments/digit-ui-components';

<Timeline
  data={[
    {
      status: "Application Submitted",
      timestamp: "2024-01-15 10:30 AM",
      description: "Application submitted successfully"
    },
    {
      status: "Under Review",
      timestamp: "2024-01-16 02:15 PM",
      description: "Application is under review"
    }
  ]}
  variant="vertical" // vertical|horizontal
/>
```

##### Rating
```jsx
import { Rating } from '@egovernments/digit-ui-components';

<Rating
  currentRating={4}
  maxRating={5}
  onRate={handleRating}
  readonly={false}
  size="medium" // small|medium|large
/>
```

#### File & Media Components

##### FileUpload
```jsx
import { FileUpload } from '@egovernments/digit-ui-components';

<FileUpload
  accept=".pdf,.doc,.docx"
  multiple={true}
  maxFileSize={5} // MB
  onFileSelect={handleFileSelect}
  uploadedFiles={uploadedFiles}
  onDelete={handleFileDelete}
  disabled={false}
/>
```

##### UploadWidget
```jsx
import { UploadWidget } from '@egovernments/digit-ui-components';

<UploadWidget
  accept="image/*"
  multiple={false}
  maxFileSize={2}
  onFileSelect={handleImageSelect}
  previewMode={true}
  cropOptions={{
    aspectRatio: 16/9,
    cropShape: "rect"
  }}
/>
```

#### Utility Components

##### Loader
```jsx
import { Loader } from '@egovernments/digit-ui-components';

<Loader
  page={false} // Full page loader if true
  size="medium" // small|medium|large
  text="Loading..."
  className="custom-loader"
/>
```

##### PopUp
```jsx
import { PopUp } from '@egovernments/digit-ui-components';

<PopUp
  type="default" // default|alert
  module="common"
  heading="Confirm Action"
  children={<div>Are you sure you want to proceed?</div>}
  footerChildren={[
    <Button key="cancel" label="Cancel" variation="secondary" />,
    <Button key="confirm" label="Confirm" variation="primary" />
  ]}
  onOverlayClick={handleClose}
  sortFooterChildren={true}
/>
```

### 2. Molecular Components (24 components)
**Complex components composed of multiple atoms**

#### Form Molecules

##### FormCard
```jsx
import { FormCard, LabelFieldPair, TextBlock } from '@egovernments/digit-ui-components';

<FormCard
  layout="2*2" // Grid layout rows*columns
  headerData={[
    <TextBlock key="header" header="Personal Information" />
  ]}
  footerData={[
    <Button key="cancel" label="Cancel" variation="secondary" />,
    <Button key="submit" label="Submit" variation="primary" />
  ]}
  withDivider={true}
  equalWidthButtons={true}
>
  <LabelFieldPair>
    <TextBlock body="First Name" />
    <TextInput name="firstName" />
  </LabelFieldPair>
  <LabelFieldPair>
    <TextBlock body="Last Name" />
    <TextInput name="lastName" />
  </LabelFieldPair>
  <LabelFieldPair>
    <TextBlock body="Email" />
    <TextInput name="email" type="email" />
  </LabelFieldPair>
  <LabelFieldPair>
    <TextBlock body="Phone" />
    <TextInput name="phone" type="numeric" />
  </LabelFieldPair>
</FormCard>
```

##### DetailsCard
```jsx
import { DetailsCard } from '@egovernments/digit-ui-components';

<DetailsCard
  data={[
    { key: "Name", value: "John Doe" },
    { key: "Email", value: "john@example.com" },
    { key: "Status", value: "Active" }
  ]}
  serviceRequestIdKey="applicationId"
  linkPrefix="/application/"
  handleSelect={handleCardSelect}
  className="details-display"
/>
```

##### MetricCard
```jsx
import { MetricCard } from '@egovernments/digit-ui-components';

<MetricCard
  metrics={[
    {
      value: "1,234",
      description: "Total Applications",
      status: "increase",
      statusmessage: "+12% from last month"
    },
    {
      value: "856",
      description: "Approved",
      status: "stable",
      statusmessage: "No change"
    }
  ]}
  layout="2*1"
  withDivider={true}
  withBottomDivider={false}
/>
```

#### Enhanced Input Molecules

##### CustomDropdown
```jsx
import { CustomDropdown } from '@egovernments/digit-ui-components';

<CustomDropdown
  options={dropdownOptions}
  selected={selectedValue}
  select={handleSelect}
  config={{
    select: (option) => ({ ...option, selected: true }),
    hasPrefix: true,
    prefixValue: "City: "
  }}
  placeholder="Select City"
  disabled={false}
/>
```

##### MultiUploadWrapper
```jsx
import { MultiUploadWrapper } from '@egovernments/digit-ui-components';

<MultiUploadWrapper
  module="common"
  tenantId="pb.amritsar"
  getFormState={(fileData) => ({
    documents: fileData
  })}
  setuploadtitle="Upload Documents"
  allowedFileTypes={["pdf", "jpg", "png"]}
  allowedMaxSizeInMB={5}
  acceptFiles="application/pdf,image/jpeg,image/png"
  commonProps={{
    maxFilesAllowed: 3,
    instructionsHeader: "Upload Instructions",
    instructionsList: [
      "File size should not exceed 5MB",
      "Only PDF, JPG, PNG formats allowed"
    ]
  }}
/>
```

### 3. Higher-Order Components (HOCs) (8 components)
**Complex orchestration components managing state and behavior**

##### FormComposerV2
```jsx
import { FormComposerV2 } from '@egovernments/digit-ui-components';

const formConfig = [
  {
    head: "Personal Information",
    body: [
      {
        type: "text",
        label: "First Name",
        populators: {
          name: "firstName",
          validation: { required: true }
        }
      },
      {
        type: "dropdown",
        label: "City",
        populators: {
          name: "city",
          optionsKey: "name",
          options: cityOptions
        }
      }
    ]
  }
];

<FormComposerV2
  config={formConfig}
  onSubmit={handleFormSubmit}
  defaultValues={initialFormData}
  horizontalNavConfig={{
    showNav: true,
    configNavItems: [
      { name: "Personal Info", active: true, code: "PERSONAL" },
      { name: "Address", active: false, code: "ADDRESS" }
    ],
    activeByDefault: "PERSONAL"
  }}
  cardStyle={{ margin: "16px 0" }}
  isDescriptionBanner={false}
  noBoxShadow={false}
  inline={false}
  className="form-composer"
/>
```

**FormComposerV2 Configuration Options:**

**Field Types Available:**
- `text` - Text input
- `number` - Numeric input  
- `email` - Email input
- `password` - Password input
- `textarea` - Multi-line text
- `dropdown` - Select dropdown
- `multiselect` - Multiple selection
- `radio` - Radio button group
- `checkbox` - Checkbox group
- `date` - Date picker
- `time` - Time picker
- `file` - File upload
- `custom` - Custom component

**Validation Rules:**
```javascript
validation: {
  required: true,
  pattern: /^[a-zA-Z\s]+$/,
  minLength: 3,
  maxLength: 50,
  min: 0,
  max: 100,
  isValidEmail: true,
  isValidMobileNumber: true,
  customValidation: (value) => value !== "restricted"
}
```

##### Modal
```jsx
import { Modal } from '@egovernments/digit-ui-components';

<Modal
  headerBarMain={<TextBlock header="Confirmation" />}
  headerBarEnd={<CloseButton onClick={handleClose} />}
  actionCancelLabel="Cancel"
  actionCancelOnSubmit={handleCancel}
  actionSaveLabel="Save"
  actionSaveOnSubmit={handleSave}
  formId="modal-form"
  style={{ width: "600px", height: "400px" }}
  hideSubmit={false}
  isDisabled={isSubmitting}
  popupStyles={{ overlay: { backgroundColor: "rgba(0,0,0,0.5)" } }}
>
  <div>Modal content goes here</div>
</Modal>
```

## Styling System

### CSS Architecture
- **CSS Variables** for theme tokens
- **SCSS mixins** for typography
- **Tailwind CSS** utility classes
- **Component-scoped styling** with BEM naming

### Color System
```javascript
// Primary Colors
'--digitv2-lightTheme-primary-1': '#C84C0E'    // Main brand color
'--digitv2-lightTheme-primary-2': '#0B4B66'    // Secondary brand color
'--digitv2-lightTheme-primary-bg': '#FBEEE8'   // Brand background

// Text Colors  
'--digitv2-lightTheme-text-primary': '#363636'    // Main text
'--digitv2-lightTheme-text-secondary': '#787878'  // Secondary text
'--digitv2-lightTheme-text-disabled': '#C5C5C5'   // Disabled text

// Alert Colors
'--digitv2-lightTheme-alert-error': '#B91900'     // Error state
'--digitv2-lightTheme-alert-success': '#00703C'   // Success state  
'--digitv2-lightTheme-alert-warning': '#9E5F00'   // Warning state
'--digitv2-lightTheme-alert-info': '#0057BD'      // Info state

// Surface Colors
'--digitv2-lightTheme-paper-primary': '#FFFFFF'   // Main backgrounds
'--digitv2-lightTheme-paper-secondary': '#FAFAFA' // Secondary backgrounds
'--digitv2-lightTheme-generic-background': '#EEEEEE' // App backgrounds
'--digitv2-lightTheme-generic-divider': '#D6D5D4'    // Borders/dividers
```

### Typography Scale
| Type | Mobile | Tablet | Desktop | Weight | Use Case |
|------|--------|--------|---------|---------|----------|
| Heading XL | 2rem | 2.25rem | 2.5rem | Bold | Page headers |
| Heading L | 1.5rem | 1.75rem | 2rem | Bold | Section headers |
| Heading M | 1.25rem | 1.25rem | 1.25rem | Bold | Card headers |
| Body L | 1rem | 1.25rem | 1.25rem | Regular | Primary text |
| Body S | 0.875rem | 1rem | 1rem | Regular | Secondary text |
| Caption M | 1.25rem | 1.5rem | 1.5rem | Medium | Captions |

### Spacing System
```javascript
// Spacer Scale (rem-based)
spacer0: "0rem"      // 0px
spacer1: "0.25rem"   // 4px  
spacer2: "0.5rem"    // 8px
spacer3: "0.75rem"   // 12px
spacer4: "1rem"      // 16px
spacer5: "1.25rem"   // 20px
spacer6: "1.5rem"    // 24px
spacer8: "2rem"      // 32px
spacer10: "2.5rem"   // 40px
spacer12: "3rem"     // 48px
```

## Common Usage Patterns

### Form Implementation Pattern
```jsx
import { 
  FormCard, 
  LabelFieldPair, 
  TextBlock, 
  TextInput, 
  Dropdown, 
  Button 
} from '@egovernments/digit-ui-components';

function UserForm({ onSubmit, initialData }) {
  const [formData, setFormData] = useState(initialData);

  const handleSubmit = () => {
    onSubmit(formData);
  };

  return (
    <FormCard
      layout="2*2"
      headerData={[<TextBlock key="header" header="User Information" />]}
      footerData={[
        <Button key="cancel" label="Cancel" variation="secondary" />,
        <Button key="submit" label="Submit" variation="primary" onClick={handleSubmit} />
      ]}
    >
      <LabelFieldPair>
        <TextBlock body="First Name*" />
        <TextInput 
          name="firstName"
          value={formData.firstName}
          onChange={(e) => setFormData({...formData, firstName: e.target.value})}
          validation={{ required: true }}
        />
      </LabelFieldPair>
      
      <LabelFieldPair>
        <TextBlock body="City*" />
        <Dropdown
          options={cityOptions}
          selected={formData.city}
          select={(city) => setFormData({...formData, city})}
        />
      </LabelFieldPair>
    </FormCard>
  );
}
```

### Data Display Pattern
```jsx
import { 
  TableMain, 
  TableHeader, 
  TableBody, 
  TableRow, 
  TableCell,
  Button,
  Chip 
} from '@egovernments/digit-ui-components';

function UserTable({ users, onEdit, onDelete }) {
  return (
    <TableMain>
      <TableHeader>
        <TableRow>
          <TableCell>Name</TableCell>
          <TableCell>Email</TableCell>
          <TableCell>Status</TableCell>
          <TableCell>Actions</TableCell>
        </TableRow>
      </TableHeader>
      <TableBody>
        {users.map(user => (
          <TableRow key={user.id}>
            <TableCell>{user.name}</TableCell>
            <TableCell>{user.email}</TableCell>
            <TableCell>
              <Chip 
                text={user.status} 
                className={`status-${user.status.toLowerCase()}`}
              />
            </TableCell>
            <TableCell>
              <Button 
                label="Edit" 
                variation="link" 
                onClick={() => onEdit(user.id)}
              />
              <Button 
                label="Delete" 
                variation="link" 
                onClick={() => onDelete(user.id)}
              />
            </TableCell>
          </TableRow>
        ))}
      </TableBody>
    </TableMain>
  );
}
```

### Modal/Dialog Pattern
```jsx
import { Modal, TextBlock, Button, FormCard } from '@egovernments/digit-ui-components';

function ConfirmationModal({ isOpen, onClose, onConfirm, title, message }) {
  return isOpen ? (
    <Modal
      headerBarMain={<TextBlock header={title} />}
      headerBarEnd={<Button icon="Close" variation="link" onClick={onClose} />}
      actionCancelLabel="Cancel"
      actionCancelOnSubmit={onClose}
      actionSaveLabel="Confirm"
      actionSaveOnSubmit={onConfirm}
      hideSubmit={false}
    >
      <FormCard>
        <TextBlock body={message} />
      </FormCard>
    </Modal>
  ) : null;
}
```

### Navigation Pattern
```jsx
import { Header, BreadCrumb, SideNav } from '@egovernments/digit-ui-components';

function AppLayout({ children, currentPath }) {
  const breadcrumbs = generateBreadcrumbs(currentPath);
  
  return (
    <div className="app-layout">
      <Header 
        logo={{ url: "/logo.png", alt: "DIGIT" }}
        rightIcon="Menu"
        onRightIconClick={toggleSideNav}
      />
      
      <BreadCrumb crumbs={breadcrumbs} />
      
      <div className="main-content">
        <SideNav 
          menuItems={navigationItems}
          selectedItem={currentPath}
          onItemSelect={handleNavigation}
        />
        
        <main className="content-area">
          {children}
        </main>
      </div>
    </div>
  );
}
```

## Key Dependencies & Peer Dependencies

### Required Dependencies
```json
{
  "react": "19.0.0",
  "react-dom": "19.0.0", 
  "react-hook-form": "^7.52.2",
  "react-i18next": "^15.0.0",
  "date-fns": "^3.6.0",
  "lodash": "^4.17.21"
}
```

### Peer Dependencies
```json
{
  "@egovernments/digit-ui-components-css": "2.0.0-dev-01",
  "@egovernments/digit-ui-svg-components": "2.0.0-dev-01",
  "@egovernments/digit-ui-libraries": "2.0.0-dev-01"
}
```

## Accessibility Features

All components include:
- **ARIA labels and roles** for screen readers
- **Keyboard navigation support** for form controls  
- **Focus management** with visible focus indicators
- **High contrast support** with semantic color usage
- **Responsive design** that works across devices
- **Semantic HTML structure** for better accessibility

## Internationalization Support

Components support i18n through react-i18next:
```jsx
import { useTranslation } from 'react-i18next';

function MyComponent() {
  const { t } = useTranslation();
  
  return (
    <Button label={t('common:submit')} />
  );
}
```

## Error Handling Patterns

Components include built-in error handling:
```jsx
<TextInput
  name="email"
  validation={{ 
    required: true,
    isValidEmail: true 
  }}
  errorStyle="error"
  errorMessage="Please enter a valid email address"
/>
```

## Performance Considerations

- Components are **tree-shakeable** for optimal bundle size
- **Lazy loading** supported for heavy components
- **Memoization** built into complex components
- **Virtual scrolling** available for large data sets

## Browser Support

- **Modern browsers** (Chrome, Firefox, Safari, Edge)
- **Mobile browsers** with responsive design
- **Accessibility tools** and screen readers
- **Touch and mouse** interaction support

---

This document provides comprehensive guidance for Claude to understand and work with the DIGIT UI Components library effectively across different sessions. All components follow consistent patterns for props, styling, and behavior, making them predictable and easy to use in government digital service applications.