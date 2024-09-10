import React from "react";
import PropTypes from "prop-types";
import { useHistory } from "react-router-dom";
import { Card, Divider, Button, StringManipulator } from "../atoms";
import { iconRender } from "../utils/iconRender";
import { Colors } from "../constants/colors/colorconstants";

const LandingPageCard = ({
  icon,
  moduleName,
  metrics = [],
  links = [],
  className,
  styles,
  moduleAlignment,
  hideDivider,
  metricAlignment,
  iconBg,
  buttonSize,
  onMetricClick,
}) => {
  const history = useHistory();

  const handleMetricClick = (link, count) => {
    onMetricClick && onMetricClick(link, count);
  };

  const handleLinkClick = ({ link, label, icon }) => {
    history?.push(link);
  };
  const primaryIconColor = Colors.lightTheme.primary[1];
  const secondaryIconColor = Colors.lightTheme.paper.primary;

  return (
    <Card
      className={`digit-landing-page-card ${moduleAlignment || ""} ${className}`}
      style={styles}
    >
      <div className={`icon-module-header ${moduleAlignment || ""}`}>
        {icon && moduleAlignment === "right" && (
          <div
            className={`digit-landingpagecard-icon ${iconBg ? "iconBg" : ""}`}
          >
            {iconRender(
              icon,
              iconBg ? secondaryIconColor : primaryIconColor,
              "56px",
              "56px",
              `digit-landingpagecard-icon ${iconBg ? "iconBg" : ""}`
            )}
          </div>
        )}
        {moduleName && (
          <div className="ladingcard-moduleName">
            {StringManipulator(
              "TOSENTENCECASE",
              StringManipulator("TRUNCATESTRING", moduleName, {
                maxLength: 64,
              })
            )}
          </div>
        )}
        {icon && moduleAlignment === "left" && (
          <div
            className={`digit-landingpagecard-icon ${iconBg ? "iconBg" : ""}`}
          >
            {iconRender(
              icon,
              iconBg ? secondaryIconColor : primaryIconColor,
              "56px",
              "56px",
              `digit-landingpagecard-icon ${iconBg ? "iconBg" : ""}`
            )}
          </div>
        )}
      </div>
      {!hideDivider && (
        <Divider className="digit-landingpage-divider" variant={"small"} />
      )}
      {metrics && metrics.length > 0 && (
        <div className={`metric-container ${metricAlignment || ""}`}>
          {metrics.map((metric, index) => (
            <div
              key={index}
              className={`metric-item ${metricAlignment || ""}`}
              onClick={() => handleMetricClick(metric?.link, metric?.count)}
            >
              {metric?.count && (
                <div className="metric-count">{metric?.count}</div>
              )}
              {metric?.label && (
                <div className="metric-label">
                  {" "}
                  {StringManipulator(
                    "TOSENTENCECASE",
                    StringManipulator("TRUNCATESTRING", metric?.label, {
                      maxLength: 64,
                    })
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
      {!hideDivider &&
        metrics &&
        metrics.length > 0 &&
        links &&
        links.length > 0 && (
          <Divider className="digit-landingpage-divider" variant={"small"} />
        )}
      {links.map(({ label, link, icon }, index) => (
        <Button
          variation="teritiary"
          label={label}
          icon={icon}
          type="button"
          size={buttonSize || "medium"}
          onClick={() => handleLinkClick({ link, label, icon })}
          style={{ padding: "0px" }}
        />
      ))}
    </Card>
  );
};

LandingPageCard.propTypes = {
  icon: PropTypes.node.isRequired,
  moduleName: PropTypes.string.isRequired,
  moduleAlignment: PropTypes.string,
  metrics: PropTypes.arrayOf(
    PropTypes.shape({
      count: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
      label: PropTypes.string,
      link: PropTypes.string,
    })
  ),
  metricAlignment: PropTypes.string,
  links: PropTypes.arrayOf(
    PropTypes.shape({
      count: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
      label: PropTypes.string,
      link: PropTypes.string,
    })
  ),
  className: PropTypes.string,
  styles: PropTypes.object,
  hideDivider: PropTypes.bool,
  iconBg: PropTypes.bool,
  onMetricClick: PropTypes.func,
};

LandingPageCard.defaultProps = {
  metris: [],
  links: [],
  className: "",
  styles: {},
  moduleAlignment: "right",
  metricAlignment: "left",
  moduleName: "",
  icon: "",
  iconBg: false,
  hideDivider: false,
  onMetricClick: () => {},
};

export default LandingPageCard;
