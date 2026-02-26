import React, { useState, useEffect } from "react";
import { FormComposer as FormComposerV2 } from "@egovernments/digit-ui-components/hoc";
import Button from "@egovernments/digit-ui-components/atoms/Button";
import TextBlock from "@egovernments/digit-ui-components/atoms/TextBlock";

export default {
  title: "Molecules/HOC/FormComposerV2",
  component: FormComposerV2,
  argTypes: {
    heading: {
      control: "text",
      name: "Form Heading",
    },
    description: {
      control: "text",
      name: "Form Description",
    },
    label: {
      control: "text",
      name: "Submit Button Label",
    },
    secondaryLabel: {
      control: "text",
      name: "Secondary Button Label",
    },
    submitInForm: {
      control: "boolean",
      name: "Submit Button Inside Form",
    },
    inline: {
      control: "boolean",
      name: "Inline Layout",
    },
    noBreakLine: {
      control: "boolean",
      name: "Remove Break Lines",
    },
    isDisabled: {
      control: "boolean",
      name: "Disable Form",
    },
    showSecondaryLabel: {
      control: "boolean",
      name: "Show Secondary Button",
    },
    config: {
      table: { disable: true },
    },
    onSubmit: {
      table: { disable: true },
    },
    onFormValueChange: {
      table: { disable: true },
    },
    defaultValues: {
      table: { disable: true },
    },
  },
};

const FormComposerV2Wrapper = (args) => {
  const [formData, setFormData] = useState({});
  const [showToast, setShowToast] = useState(false);

  const handleSubmit = (data) => {
    console.log("Form Submitted:", data);
    setFormData(data);
    setShowToast(true);
    setTimeout(() => setShowToast(false), 3000);
  };

  const handleSecondaryAction = () => {
    console.log("Secondary action clicked");
  };

  const handleFormValueChange = (setValue, formData, formState) => {
    console.log("Form values changed:", formData);
  };

  return (
    <div>
      <FormComposerV2 
        {...args} 
        onSubmit={handleSubmit}
        onSecondayActionClick={handleSecondaryAction}
        onFormValueChange={handleFormValueChange}
      />
      {showToast && (
        <div style={{
          position: "fixed",
          bottom: "20px",
          right: "20px",
          background: "#4CAF50",
          color: "white",
          padding: "16px",
          borderRadius: "4px",
          boxShadow: "0 2px 5px rgba(0,0,0,0.2)"
        }}>
          Form submitted successfully!
        </div>
      )}
      {Object.keys(formData).length > 0 && (
        <div style={{ marginTop: "20px", padding: "16px", background: "#f5f5f5", borderRadius: "4px" }}>
          <h4>Form Data:</h4>
          <pre>{JSON.stringify(formData, null, 2)}</pre>
        </div>
      )}
    </div>
  );
};

const Template = (args) => <FormComposerV2Wrapper {...args} />;

// Basic configuration
const basicConfig = [
  {
    head: "Personal Information",
    subHead: "Please provide your personal details",
    body: [
      {
        type: "text",
        label: "Full Name",
        isMandatory: true,
        populators: {
          name: "fullName",
          validation: {
            required: true,
            pattern: /^[a-zA-Z\s]*$/,
          },
          error: "Please enter a valid name"
        }
      },
      {
        type: "text",
        label: "Email Address",
        isMandatory: true,
        populators: {
          name: "email",
          validation: {
            required: true,
            pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
          },
          error: "Please enter a valid email"
        }
      },
      {
        type: "mobileNumber",
        label: "Mobile Number",
        isMandatory: true,
        populators: {
          name: "mobileNumber",
          validation: {
            required: true,
            pattern: /^[0-9]{10}$/,
          },
          error: "Please enter a valid 10-digit mobile number"
        }
      },
      {
        type: "date",
        label: "Date of Birth",
        isMandatory: false,
        populators: {
          name: "dateOfBirth",
        }
      }
    ]
  }
];

// Advanced configuration with multiple sections
const advancedConfig = [
  {
    head: "Employee Details",
    body: [
      {
        type: "text",
        label: "Employee ID",
        isMandatory: true,
        populators: {
          name: "employeeId",
          validation: {
            required: true,
          }
        }
      },
      {
        type: "text", 
        label: "Department",
        isMandatory: true,
        populators: {
          name: "department",
          validation: {
            required: true,
          }
        }
      },
      {
        type: "dropdown",
        label: "Designation",
        isMandatory: true,
        populators: {
          name: "designation",
          options: [
            { code: "SE", name: "Software Engineer" },
            { code: "SSE", name: "Senior Software Engineer" },
            { code: "TL", name: "Team Lead" },
            { code: "PM", name: "Project Manager" }
          ],
          optionKey: "name",
        }
      }
    ]
  },
  {
    head: "Address Information",
    body: [
      {
        type: "textarea",
        label: "Current Address",
        isMandatory: true,
        populators: {
          name: "currentAddress",
          validation: {
            required: true,
          }
        }
      },
      {
        type: "text",
        label: "City",
        isMandatory: true,
        populators: {
          name: "city",
          validation: {
            required: true,
          }
        }
      },
      {
        type: "text",
        label: "Pincode",
        isMandatory: true,
        populators: {
          name: "pincode",
          validation: {
            required: true,
            pattern: /^[0-9]{6}$/,
          },
          error: "Please enter a valid 6-digit pincode"
        }
      },
      {
        type: "checkbox",
        label: "Same as Permanent Address",
        populators: {
          name: "sameAsPermanent",
        }
      }
    ]
  }
];

// Complex form with custom components
const complexConfig = [
  {
    head: "Application Form",
    body: [
      {
        type: "text",
        label: "Application Number",
        isMandatory: true,
        populators: {
          name: "applicationNumber",
          validation: {
            required: true,
          }
        }
      },
      {
        type: "radio",
        label: "Application Type",
        isMandatory: true,
        populators: {
          name: "applicationType",
          options: [
            { code: "new", name: "New Application" },
            { code: "renewal", name: "Renewal" },
            { code: "modification", name: "Modification" }
          ],
          optionKey: "name",
        }
      },
      {
        type: "multiselect",
        label: "Services Required",
        isMandatory: true,
        populators: {
          name: "services",
          options: [
            { code: "water", name: "Water Connection" },
            { code: "sewerage", name: "Sewerage Connection" },
            { code: "electricity", name: "Electricity" },
            { code: "garbage", name: "Garbage Collection" }
          ],
          optionKey: "name",
        }
      },
      {
        type: "file",
        label: "Upload Documents",
        populators: {
          name: "documents",
        }
      },
      {
        type: "custom",
        component: "InfoBanner",
        populators: {
          name: "info",
          label: "Please ensure all documents are in PDF format and less than 5MB"
        }
      }
    ]
  }
];

// Form with navigation tabs
const tabConfig = [
  {
    navLink: "personal",
    head: "Personal Details",
    body: [
      {
        type: "text",
        label: "First Name",
        isMandatory: true,
        populators: {
          name: "firstName",
          validation: { required: true }
        }
      },
      {
        type: "text",
        label: "Last Name",
        isMandatory: true,
        populators: {
          name: "lastName",
          validation: { required: true }
        }
      }
    ]
  },
  {
    navLink: "contact",
    head: "Contact Details",
    body: [
      {
        type: "text",
        label: "Email",
        isMandatory: true,
        populators: {
          name: "contactEmail",
          validation: { required: true }
        }
      },
      {
        type: "mobileNumber",
        label: "Phone",
        isMandatory: true,
        populators: {
          name: "contactPhone",
          validation: { required: true }
        }
      }
    ]
  }
];

const horizontalNavConfig = [
  { name: "personal", displayName: "Personal", activeByDefault: true },
  { name: "contact", displayName: "Contact" }
];

export const BasicForm = Template.bind({});
BasicForm.args = {
  config: basicConfig,
  heading: "Registration Form",
  description: "Please fill in all the required fields",
  label: "Submit",
  submitInForm: false,
  inline: false,
  noBreakLine: false,
  isDisabled: false,
};

export const AdvancedForm = Template.bind({});
AdvancedForm.args = {
  config: advancedConfig,
  heading: "Employee Registration",
  label: "Register",
  secondaryLabel: "Cancel",
  showSecondaryLabel: true,
  submitInForm: false,
  inline: false,
};

export const InlineForm = Template.bind({});
InlineForm.args = {
  config: basicConfig,
  heading: "Quick Registration",
  label: "Submit",
  submitInForm: true,
  inline: true,
  noBreakLine: true,
};

export const FormWithTabs = Template.bind({});
FormWithTabs.args = {
  config: tabConfig,
  heading: "Multi-Step Registration",
  label: "Complete Registration",
  showFormInNav: true,
  showNavs: true,
  horizontalNavConfig: horizontalNavConfig,
  submitInForm: false,
};

export const DisabledForm = Template.bind({});
DisabledForm.args = {
  config: basicConfig,
  heading: "View Only Form",
  description: "This form is in read-only mode",
  label: "Submit",
  isDisabled: true,
  defaultValues: {
    fullName: "John Doe",
    email: "john.doe@example.com",
    mobileNumber: "9876543210",
    dateOfBirth: "1990-01-01"
  }
};

export const FormWithDefaultValues = Template.bind({});
FormWithDefaultValues.args = {
  config: advancedConfig,
  heading: "Edit Employee Details",
  label: "Update",
  secondaryLabel: "Reset",
  showSecondaryLabel: true,
  defaultValues: {
    employeeId: "EMP001",
    department: "Engineering",
    designation: { code: "SSE", name: "Senior Software Engineer" },
    currentAddress: "123 Main Street",
    city: "Bangalore",
    pincode: "560001"
  }
};

BasicForm.storyName = "Basic Form";
AdvancedForm.storyName = "Advanced Multi-Section Form";
InlineForm.storyName = "Inline Form Layout";
FormWithTabs.storyName = "Form with Navigation Tabs";
DisabledForm.storyName = "Disabled/Read-Only Form";
FormWithDefaultValues.storyName = "Form with Default Values";