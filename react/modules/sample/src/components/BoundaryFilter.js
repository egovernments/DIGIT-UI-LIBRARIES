import React, { useEffect, useState } from 'react'
import { Card, CardText, MultiSelectDropdown } from '@egovernments/digit-ui-components'
import { CheckBox } from '@egovernments/digit-ui-react-components';
import { useTranslation } from 'react-i18next';
import { LabelFieldPair, CardLabel } from "@egovernments/digit-ui-components";

const BoundaryFilter = (props) => {
  const hierarchyType = props?.hierarchyType;
  const tenantId = Digit.ULBService.getCurrentTenantId();
  const [lowestHierarchy, setLowestHierarchy] = useState("")
  const [nonEditableHierarchies, setNonEditableHierarchies] = useState(new Set())
  const { t } = useTranslation();
  const moduleName = props?.module;

  const processHierarchy = (nodes, parentPath = "") => {
    return nodes.map((node) => {
      // Construct the current node's full path using its code
      const currentPath = parentPath ? `${parentPath}.${node.code}` : node.code;

      // Process children if they exist
      if (node.children && node.children.length > 0) {
        node.children = processHierarchy(node.children, currentPath);
      }

      // Attach the path attribute
      return { ...node, path: currentPath };
    });
  };


  const { data: BOUNDARY_HIERARCHY_TYPE } = Digit.Hooks.useCustomMDMS(tenantId, moduleName, [{ name: "HierarchySchema" }], {
    select: (data) => {
      const item = data?.[moduleName]?.HierarchySchema?.find(
        (item) => item.type === "microplan"
      );
      setLowestHierarchy(item.lowestHierarchy)
      return item?.hierarchy
    },
  }, { schemaCode: "BASE_MASTER_DATA_INITIAL" });


  const reqHierarchyData = {
    url: `/boundary-service/boundary-relationships/_search`,
    changeQueryName: `${BOUNDARY_HIERARCHY_TYPE}`,
    params: {
      tenantId: tenantId,
      hierarchyType: hierarchyType,
      includeChildren: true
    },
    body: {},
    config: {
      enabled: BOUNDARY_HIERARCHY_TYPE ? true : false,
      select: (data) => {
        // Recursive function to process hierarchy and attach paths
        const processHierarchy = (nodes, parentPath = "") => {
          return nodes.map((node) => {
            // Construct the current node's full path using its code
            const currentPath = parentPath ? `${parentPath}.${node.code}` : node.code;

            // Process children if they exist
            if (node.children && node.children.length > 0) {
              node.children = processHierarchy(node.children, currentPath);
            }

            // Attach the path attribute
            return { ...node, path: currentPath };
          });
        };

        return processHierarchy(data?.TenantBoundary?.[0]?.boundary)
      }
    }
  };

  const { data: hierarchyData, refetch, isLoading } = Digit.Hooks.useCustomAPIHook(reqHierarchyData);


  const [boundaryOptions, setBoundaryOptions] = useState({});
  const [selectedValues, setSelectedValues] = useState([]);

  const reqCriteria = {
    url: `/boundary-service/boundary-hierarchy-definition/_search`,
    changeQueryName: `${hierarchyType}`,
    body: {
      BoundaryTypeHierarchySearchCriteria: {
        tenantId: 'dev',
        limit: 2,
        offset: 0,
        hierarchyType: hierarchyType,
      },
    },
    config: {
      select: (data) => {
        return data?.BoundaryHierarchy[0]?.boundaryHierarchy
      }
    }
  };

  const { isLoading: hierarchyLoading, data: hierarchy } = Digit.Hooks.useCustomAPIHook(reqCriteria);




  useEffect(() => {
    if (hierarchy) {
    }
  }, [hierarchy]);

  useEffect(() => {
    if (BOUNDARY_HIERARCHY_TYPE) {
    }
  }, [BOUNDARY_HIERARCHY_TYPE]);

  useEffect(() => {

    if (hierarchy) {
      const highestIndex = hierarchy?.findIndex(item => item?.boundaryType === props?.highestLevel);

      if (highestIndex !== -1) {
        const tempNonEditableHierarchies = new Set(hierarchy.slice(0, highestIndex).map(item => item.boundaryType));

        setNonEditableHierarchies(tempNonEditableHierarchies);
      }
    }
  }, [hierarchy, props.highestLevel]);

  const rootBoundaryType = hierarchy?.filter((item) => item?.parentBoundaryType === null)[0]?.boundaryType;

  const findNodeByPath = (nodes, targetPath) => {
    if (!nodes || nodes.length == 0) { return }
    for (const node of nodes) {
      if (node.path === targetPath) {
        return node.children?.map(child => ({ code: child.code, id: child.id, path: child.path, boundaryType: child.boundaryType })) || [];
      }
      if (node.children && node.children.length > 0) {
        const result = findNodeByPath(node.children, targetPath);
        if (result) return result; // If found in the recursive call, return result
      }
    }
    return null; // Return null if no match is found
  };

  const recursiveCleanup = (currentBoundaryType, updatedOptions, codesToRemove) => {
    const childType = hierarchy.find(item => item.parentBoundaryType === currentBoundaryType)?.boundaryType;
    if (!childType || !updatedOptions[childType]) return updatedOptions;

    Object.keys(updatedOptions[childType]).forEach(code => {

      const shouldDelete = updatedOptions[childType][code].some(child => {
        const hasMatch = codesToRemove.some(code => child.path.includes(code));
        return hasMatch;
      });



      if (shouldDelete) {
        delete updatedOptions[childType][code];
      }
    });


    // Recursively clean next level
    return recursiveCleanup(childType, updatedOptions, codesToRemove);
  };

  const cleanLowerLevels = (boundaryType, codesToRemove, updatedOptions) => {
    if (codesToRemove.length == 0) return updatedOptions;
    let newBoundaryOptions = recursiveCleanup(boundaryType, updatedOptions, codesToRemove);
    return newBoundaryOptions; // Return the final updated state
  };

  const cleanLowerLevelsForSelectedValues = (boundaryType, removedCodes, updatedOptions) => {
    return updatedOptions.filter(option => {
      // Ensure path is a valid string before checking `includes`
      if (typeof option?.path !== "string") return true;

      return !removedCodes.some(code => option.path.includes(code));
    });
  };


  const boundaryOptionsUpdate = async (boundaryType, values) => {
    if (!Array.isArray(values)) return;

    const selectedOptions = values.map(arg => arg[1]) || [];
    const childBoundaryType = hierarchy.find(
      (item) => item.parentBoundaryType === boundaryType
    )?.boundaryType;

    const removedCodes = [];
    const processRemovedCodes = (previousValues, selectedCodes) => {
      Object.keys(previousValues).forEach(code => {
        if (!selectedCodes.has(code)) {
          removedCodes.push(code);
        }
      });
    };

    const previousValues = boundaryOptions[childBoundaryType] || {};
    const selectedCodes = new Set(selectedOptions.map(v => v.code));
    processRemovedCodes(previousValues, selectedCodes);

    const updatedOptions = boundaryOptions;
    let newBoundaryOptions = {};
    let newSelectedOptions = {};
    if (removedCodes.length > 0) {
      newBoundaryOptions = cleanLowerLevels(boundaryType, removedCodes, { ...boundaryOptions });
      newSelectedOptions = cleanLowerLevelsForSelectedValues(boundaryType, removedCodes, [...selectedValues]);
    }
      // Reset removedCodes after processing
    else {
      newBoundaryOptions = updatedOptions;
      newSelectedOptions = cleanLowerLevelsForSelectedValues(boundaryType, removedCodes, [...selectedValues]);
    }
    



    // **Accumulate changes before updating state**
    let updatedSelectedValues = [...newSelectedOptions];

    setBoundaryOptions((prev) => {
      let updatedOptions = { ...newBoundaryOptions };

      // **Memoizing the children lookups**
      const childrenMap = new Map();

      selectedOptions.forEach((value) => {

        // **Update selected values locally**
        const existingCodes = new Set(updatedSelectedValues.map(v => v.code));
        if (!existingCodes.has(value.code)) {
          updatedSelectedValues.push(value);
        }

        if (boundaryType !== props.lowestLevel) {
          if (!childrenMap.has(value?.path)) {
            childrenMap.set(value?.path, findNodeByPath(hierarchyData, value?.path));
          }
          const children = childrenMap.get(value?.path);

          updatedOptions[childBoundaryType] = updatedOptions[childBoundaryType] || {};
          updatedOptions[childBoundaryType][value?.code] = updatedOptions[childBoundaryType][value?.code] || [];

          const existingEntries = new Set(
            updatedOptions[childBoundaryType][value?.code].map(child => child.code)
          );


          const uniqueChildren = children.filter(child => !existingEntries.has(child.code));

          updatedOptions[childBoundaryType][value?.code] = [
            ...updatedOptions[childBoundaryType][value?.code],
            ...uniqueChildren
          ];
        }
      });

      return updatedOptions;
    });

    // **Update selected values once at the end**
    setSelectedValues(updatedSelectedValues);
  };

  const initializeBoundaries = (nodes, updatedOptions, nonEditableHierarchies) => {
    if (!nodes || nodes.length === 0) return updatedOptions;

    // If the current node's boundaryType is not in the editable set, return early
    if (!nonEditableHierarchies.has(nodes[0]?.boundaryType)) {
      return updatedOptions;
    }

    // Find the child boundary type of the current level
    const childBoundaryType = hierarchy.find(
      (item) => item.parentBoundaryType === nodes[0]?.boundaryType
    )?.boundaryType;

    if (!childBoundaryType) return updatedOptions; // If no child boundaryType exists, return

    // Ensure the structure exists in updatedOptions
    updatedOptions[childBoundaryType] = updatedOptions[childBoundaryType] || {};

    for (const node of nodes) {
      updatedOptions[childBoundaryType][node.code] =
        updatedOptions[childBoundaryType][node.code] || [];

      // Extract relevant children details
      const children = node.children?.map(child => ({
        code: child.code,
        id: child.id,
        path: child.path,
        boundaryType: child.boundaryType
      })) || [];

      updatedOptions[childBoundaryType][node.code].push(...children);

      // Recursively process child nodes while persisting updatedOptions
      initializeBoundaries(node.children, updatedOptions, nonEditableHierarchies);
    }

    return updatedOptions; // Always return the modified object
  };

  useEffect(() => {
    if (!hierarchyData || !hierarchy) return;

    // Initialize boundary options with root boundary type
    let initialBoundaryOptions = {
      [rootBoundaryType]: [{
        path: hierarchyData[0]?.path,
        code: hierarchyData[0]?.code,
        id: hierarchyData[0]?.id,
        parent: null
      }]
    };

    // Initialize with a new object to ensure no unwanted mutations occur
    let tempBoundaryOptions = initializeBoundaries(
      hierarchyData,
      { ...initialBoundaryOptions },
      nonEditableHierarchies
    );

    // Ensure that all levels exist even if they have no children
    hierarchy.forEach((item) => {
      if (!nonEditableHierarchies.has(item?.boundaryType) && item?.boundaryType !== props.highestLevel) {
        tempBoundaryOptions[item?.boundaryType] = {};
      }
    });

    setBoundaryOptions(tempBoundaryOptions);

  }, [hierarchyData, hierarchy, nonEditableHierarchies]);


  return (
    <Card>
      <div className="selecting-boundary-div">
        {
          hierarchy && hierarchyData && boundaryOptions[rootBoundaryType] && hierarchy?.filter((boundary, index) => {
            // Find the index of the lowest hierarchy
            const lowestIndex = hierarchy?.findIndex((item) => item?.boundaryType === props.lowestLevel);
            const highestIndex = hierarchy?.findIndex((item) => item?.boundaryType === props.highestLevel);
            return highestIndex <= index && index <= lowestIndex;
          })?.map((item) => {


            return (item?.boundaryType === rootBoundaryType) ? (
              <LabelFieldPair style={{ alignItems: "flex-start", paddingRight: "30%" }}>
                <CardLabel className={"boundary-selection-label"}>
                  {item?.boundaryType}
                </CardLabel>
                <div className="digit-field">
                  <MultiSelectDropdown
                    key={item?.boundaryType}
                    clearLabel="Clear All"
                    options={boundaryOptions[rootBoundaryType]}
                    optionsKey={"code"}
                    t={t}
                    onSelect={(values) => {
                      boundaryOptionsUpdate(item?.boundaryType, values);
                    }}
                    type="multiselectdropdown"
                    config={{
                      isDropdownWithChip: true
                    }}
                  />
                </div>
              </LabelFieldPair>)
              : (() => {
                const boundaries = boundaryOptions[item?.boundaryType];

                if (boundaries) {
                  const formattedOptions = Object.keys(boundaries).map((parentKey) => ({
                    code: parentKey,
                    name: parentKey,
                    options: boundaries[parentKey].map((child) => ({
                      code: child.code,
                      name: child.code,
                      path: child.path,
                      parent: parentKey,
                      boundaryType: child.boundaryType
                    })),
                  }));


                  const formattedSelectedValues = selectedValues.filter((child) => child?.boundaryType === item?.boundaryType);

                  return (
                    <LabelFieldPair style={{ alignItems: "flex-start", paddingRight: "30%" }}>
                      <CardLabel className={"boundary-selection-label"}>
                        {t((hierarchyType + "_" + item?.boundaryType).toUpperCase())}
                      </CardLabel>
                      <div className="digit-field">
                        <MultiSelectDropdown
                          key={item?.boundaryType}
                          clearLabel="Clear All"
                          options={formattedOptions}
                          selected={formattedSelectedValues}
                          optionsKey={"name"}
                          t={t}
                          onSelect={(values) => {
                            boundaryOptionsUpdate(item?.boundaryType, values);
                          }}
                          addCategorySelectAllCheck={true}
                          addSelectAllCheck={true}
                          type="multiselectdropdown"
                          variant="nestedmultiselect"
                          config={{
                            isDropdownWithChip: true,
                            chipKey: "code"
                          }}
                        />
                      </div>
                    </LabelFieldPair>
                  );
                }


                return null; // Avoids rendering errors when `boundaries` is undefined
              })();

          })}
      </div>


    </Card>
  );


}

export default BoundaryFilter       