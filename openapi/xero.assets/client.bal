// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# This is a generated connector for [Xero Assets API v2.9.4](https://developer.xero.com/documentation/api/assets/overview/) OpenAPI specification.
# The Assets API exposes fixed asset related functions of the Xero Accounting application and can be used for a variety of purposes such as creating assets, retrieving asset valuations etc.
@display {label: "Xero Assets", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials.
    # Create a [Xero account](https://www.xero.com/signup/api/) and obtain tokens following [this guide](https://developer.xero.com/documentation/getting-started-guide/).
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.xero.com/assets.xro/1.0") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # searches fixed asset types
    #
    # + xeroTenantId - Xero identifier for Tenant 
    # + return - search results matching criteria 
    remote isolated function getAssetTypes(string xeroTenantId) returns AssetType[]|error {
        string resourcePath = string `/AssetTypes`;
        map<any> headerValues = {"xero-tenant-id": xeroTenantId};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        AssetType[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # adds a fixed asset type
    #
    # + xeroTenantId - Xero identifier for Tenant 
    # + payload - Asset type to add 
    # + return - results single object -  created fixed type 
    remote isolated function createAssetType(string xeroTenantId, AssetType payload) returns AssetType|error {
        string resourcePath = string `/AssetTypes`;
        map<any> headerValues = {"xero-tenant-id": xeroTenantId};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        AssetType response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # searches fixed asset
    #
    # + xeroTenantId - Xero identifier for Tenant 
    # + status - Required when retrieving a collection of assets. See Asset Status Codes 
    # + page - Results are paged. This specifies which page of the results to return. The default page is 1. 
    # + pageSize - The number of records returned per page. By default the number of records returned is 10. 
    # + orderBy - Requests can be ordered by AssetType, AssetName, AssetNumber, PurchaseDate and PurchasePrice. If the asset status is DISPOSED it also allows DisposalDate and DisposalPrice. 
    # + sortDirection - ASC or DESC 
    # + filterBy - A string that can be used to filter the list to only return assets containing the text. Checks it against the AssetName, AssetNumber, Description and AssetTypeName fields. 
    # + return - search results matching criteria 
    remote isolated function getAssets(string xeroTenantId, AssetStatusQueryParam status, int? page = (), int? pageSize = (), string? orderBy = (), string? sortDirection = (), string? filterBy = ()) returns Assets|error {
        string resourcePath = string `/Assets`;
        map<anydata> queryParam = {"status": status, "page": page, "pageSize": pageSize, "orderBy": orderBy, "sortDirection": sortDirection, "filterBy": filterBy};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"xero-tenant-id": xeroTenantId};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Assets response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # adds a fixed asset
    #
    # + xeroTenantId - Xero identifier for Tenant 
    # + payload - Fixed asset you are creating 
    # + return - return single object - create new asset 
    remote isolated function createAsset(string xeroTenantId, Asset payload) returns Asset|error {
        string resourcePath = string `/Assets`;
        map<any> headerValues = {"xero-tenant-id": xeroTenantId};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Asset response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Retrieves fixed asset by id
    #
    # + xeroTenantId - Xero identifier for Tenant 
    # + id - fixed asset id for single object 
    # + return - search results matching criteria 
    remote isolated function getAssetById(string xeroTenantId, string id) returns Asset|error {
        string resourcePath = string `/Assets/${getEncodedUri(id)}`;
        map<any> headerValues = {"xero-tenant-id": xeroTenantId};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Asset response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # searches fixed asset settings
    #
    # + xeroTenantId - Xero identifier for Tenant 
    # + return - search results matching criteria 
    remote isolated function getAssetSettings(string xeroTenantId) returns Setting|error {
        string resourcePath = string `/Settings`;
        map<any> headerValues = {"xero-tenant-id": xeroTenantId};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Setting response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
}
