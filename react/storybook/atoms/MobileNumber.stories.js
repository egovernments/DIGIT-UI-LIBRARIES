import React, { useState, useEffect } from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import FieldV1 from "@egovernments/digit-ui-components/atoms/../hoc/FieldV1";

// Create a QueryClient instance once (outside of render)
const queryClient = new QueryClient();

// Mock country code data
const MOCK_COUNTRY_CODES = {
  "common-masters": {
    CountryCodes: [
      { code: "IN", dialCode: "+91", name: "India", active: true },
      { code: "US", dialCode: "+1", name: "United States", active: true },
      { code: "GB", dialCode: "+44", name: "United Kingdom", active: true },
      { code: "AU", dialCode: "+61", name: "Australia", active: true },
      { code: "CA", dialCode: "+1", name: "Canada", active: true },
      { code: "DE", dialCode: "+49", name: "Germany", active: true },
      { code: "FR", dialCode: "+33", name: "France", active: true },
      { code: "JP", dialCode: "+81", name: "Japan", active: true },
      { code: "SG", dialCode: "+65", name: "Singapore", active: true },
      { code: "AE", dialCode: "+971", name: "UAE", active: true },
      { code: "SA", dialCode: "+966", name: "Saudi Arabia", active: true },
      { code: "BD", dialCode: "+880", name: "Bangladesh", active: true },
      { code: "LK", dialCode: "+94", name: "Sri Lanka", active: true },
      { code: "NP", dialCode: "+977", name: "Nepal", active: true },
      { code: "PK", dialCode: "+92", name: "Pakistan", active: true },
    ],
  },
};

// Save reference to original hook ONCE at module level (before any decorator overwrites it)
const _originalUseCustomMDMS = window.Digit?.Hooks?.useCustomMDMS;
let _mockInstalled = false;

function installMock() {
  if (_mockInstalled) return;
  if (window.Digit && window.Digit.Hooks) {
    window.Digit.Hooks.useCustomMDMS = (tenantId, moduleName, masterDetails, config) => {
      if (moduleName === "common-masters" && masterDetails?.[0]?.name === "CountryCodes") {
        const selected = config?.select ? config.select(MOCK_COUNTRY_CODES) : MOCK_COUNTRY_CODES;
        return { isLoading: false, data: selected };
      }
      // For non-country-code calls, return empty (don't call original to avoid useQuery without provider)
      return { isLoading: false, data: [] };
    };
    _mockInstalled = true;
  }
}

export default {
  title: "Atoms/Mobile Number",
  component: FieldV1,
  argTypes: {
    showCountryCodeDropdown: {
      control: "boolean",
      name: "Show Country Code Dropdown",
    },
    prefix: {
      control: "text",
      name: "Prefix (static, used when dropdown is off)",
    },
    hideSpan: {
      control: "boolean",
      name: "Hide Prefix",
    },
    maxLength: {
      control: "number",
      name: "Max Length",
    },
    defaultCountryCode: {
      control: "text",
      name: "Default Country Code",
    },
    State: {
      control: "select",
      options: ["Default", "Disabled"],
    },
    label: { control: "text", name: "Label" },
    placeholder: { control: "text", name: "Inner Label" },
    description: { control: "text", name: "Help Text" },
    required: { control: "boolean", name: "Mandatory" },
    error: { control: "text", name: "Error" },
    infoMessage: { control: "text", name: "Tooltip" },
    onChange: { action: "onChange", table: { disable: true } },
    config: { table: { disable: true } },
    populators: { table: { disable: true } },
    value: { table: { disable: true } },
    type: { table: { disable: true } },
  },
  decorators: [
    (Story) => {
      installMock();
      return (
        <QueryClientProvider client={queryClient}>
          <Story />
        </QueryClientProvider>
      );
    },
  ],
};

const Template = (args) => {
  const { State, showCountryCodeDropdown, prefix, hideSpan, maxLength, defaultCountryCode, ...rest } = args;
  const [value, setValue] = useState(args.value || "");

  useEffect(() => {
    setValue(args.value || "");
  }, [args.showCountryCodeDropdown]);

  const handleInputChange = (event) => {
    if (event?.target) {
      setValue(event.target.value);
      args.onChange(event);
    } else {
      setValue(event);
      args.onChange(event);
    }
  };

  return (
    <div>
      <FieldV1
        {...rest}
        type="mobileNumber"
        disabled={State === "Disabled"}
        value={value}
        onChange={handleInputChange}
        populators={{
          name: "phone",
          prefix,
          hideSpan,
          maxLength,
          showCountryCodeDropdown,
          countryCodeConfig: showCountryCodeDropdown
            ? { moduleName: "common-masters", masterName: "CountryCodes" }
            : undefined,
          defaultCountryCode,
        }}
      />
      <div style={{ marginTop: "1rem", padding: "0.75rem", background: "#f5f5f5", borderRadius: "4px", fontSize: "0.875rem" }}>
        <strong>Form Value:</strong> <code>{value || "(empty)"}</code>
      </div>
    </div>
  );
};

const commonArgs = {
  label: "Phone Number",
  placeholder: "Enter phone number",
  description: "Enter your mobile number",
  required: true,
  error: "",
  infoMessage: "",
  State: "Default",
  prefix: "+91",
  hideSpan: false,
  maxLength: 10,
  showCountryCodeDropdown: false,
  defaultCountryCode: "+91",
};

// Static prefix (default behavior)
export const WithStaticPrefix = Template.bind({});
WithStaticPrefix.args = {
  ...commonArgs,
};

// Country code dropdown enabled
export const WithCountryCodeDropdown = Template.bind({});
WithCountryCodeDropdown.args = {
  ...commonArgs,
  showCountryCodeDropdown: true,
};

// No prefix at all
export const WithoutPrefix = Template.bind({});
WithoutPrefix.args = {
  ...commonArgs,
  prefix: "",
  hideSpan: true,
};

// Disabled state with dropdown
export const DisabledWithDropdown = Template.bind({});
DisabledWithDropdown.args = {
  ...commonArgs,
  showCountryCodeDropdown: true,
  State: "Disabled",
};
