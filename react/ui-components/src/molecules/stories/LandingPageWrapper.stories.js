import React, { Fragment } from "react";
import LandingPageCard from "../LandingPageCard";
import LandingPageWrapper from "../LandingPageWrapper";

export default {
  title: "MoleculeGroup/LandingPageWrapper",
  component: LandingPageWrapper,
};

const Template = (args) => <LandingPageWrapper {...args} />;

export const Example1 = Template.bind({});

Example1.args = {
  children: (
    <>
      <LandingPageCard
        icon="SupervisorAccount"
        moduleName="Dashboard"
        metrics={[
          { count: 10, label: "Active Users", link: "#" },
          { count: 20, label: "New Users", link: "#" },
        ]}
        links={[{ label: "View Dashboard", link: "#", icon: "Dashboard" }]}
      />
      <LandingPageCard
        icon="Person"
        moduleName="User Management"
        metrics={[
          { count: 100, label: "Total Users", link: "#" },
          { count: 50, label: "New Registrations", link: "#" },
        ]}
        links={[
          { label: "Add User", link: "#", icon: "Person" },
          { label: "Edit User", link: "#", icon: "Edit" },
        ]}
      />
      <LandingPageCard
        icon="Notifications"
        moduleName="Notifications"
        metrics={[{ count: 5, label: "New Notifications", link: "#" }]}
        links={[
          { label: "View Notifications", link: "#", icon: "Notifications" },
        ]}
      />
    </>
  ),
};

export const Example2 = Template.bind({});

Example2.args = {
  children: (
    <>
      <LandingPageCard
        icon="SupervisorAccount"
        moduleAlignment={"left"}
        iconBg={true}
        moduleName="Dashboard"
        metrics={[
          { count: 10, label: "Active Users", link: "#" },
          { count: 20, label: "New Users", link: "#" },
        ]}
        links={[{ label: "View Dashboard", link: "#", icon: "Dashboard" }]}
      />
      <LandingPageCard
        icon="Person"
        moduleAlignment={"left"}
        iconBg={true}
        moduleName="User Management"
        metrics={[
          { count: 100, label: "Total Users", link: "#" },
          { count: 50, label: "New Registrations", link: "#" },
        ]}
        links={[
          { label: "Add User", link: "#", icon: "Add" },
          { label: "Edit User", link: "#", icon: "Edit" },
        ]}
      />
      <LandingPageCard
        moduleAlignment={"left"}
        iconBg={true}
        icon="Notifications"
        moduleName="Notifications"
        metrics={[{ count: 5, label: "New Notifications", link: "#" }]}
        links={[
          { label: "View Notifications", link: "#", icon: "Notifications" },
        ]}
      />
    </>
  ),
};
