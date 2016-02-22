import {Injectable} from 'angular2/core';
import {Http, URLSearchParams, Headers} from 'angular2/http';
import {Observable} from 'rxjs/Observable';

@Injectable()
export class VisualTalesHttpService<T> {
  private _putPostHeaders:Headers;
  private _url:string;
  
  constructor(private _http:Http) {
    this._putPostHeaders = new Headers();
    this._putPostHeaders.append('Content-Type', 'application/json');
  }
  
  setUrl(url:string){
    this._url = `api/${url}`;
  }
  
  get(id:number):Observable<T>{
    return this._http.get(this._url + '/' + id)
                .map(res => <T> res.json())
                .catch(this.logError);
  }
  
  getAll(params:any):Observable<T[]>{
    let urlParams:URLSearchParams = this.getUrlParams(params);    
    
    return this._http.get(this._url, {search:urlParams})
               .map(res => <T[]> res.json())
               .catch(this.logError);
  }
  
  private getUrlParams(params:any):URLSearchParams{
    let urlParams:URLSearchParams = new URLSearchParams();
    
    if(!params){
      return urlParams;
    }
    
    return Object.keys(params)
                .reduce(function(searchParams, keyName){
                  searchParams.set(keyName, params[keyName]);
                  return searchParams;
                }, urlParams);
  }
  
  update(payload:any):Observable<T>{
    return this._http.put(
              this._url + '/' + payload.id, 
              JSON.stringify(payload), 
              {headers: this._putPostHeaders}
            )
            .map(res => <T> res.json())
            .catch(this.logError);
  }
  
  create(payload:any):Observable<T>{
    return this._http.post(
              this._url + '/' + payload.id,
              JSON.stringify(payload),
              {headers: this._putPostHeaders}
           )
           .map(res => <T> res.json())
           .catch(this.logError);
  }
  
  private logError(error: Error){
    console.log(error);
    return Observable.throw(error);
  }
}