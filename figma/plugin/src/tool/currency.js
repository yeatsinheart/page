import Decimal from "decimal.js";
import {appStore} from "@/config/store/app.js";

function isStrictNumber(str) {
    const regex = /^(0|[1-9]\d*)(\.\d+)?$/;
    return regex.test(str);
}


export class CurrencyUtil {
    static coinToCurrency(amount,exchangeRate,scale,denomination) {
        if (isNaN(amount) || !isStrictNumber(amount)) return null;
        /// 游戏币 乘面值 除 汇率
        return this.roundToScale(new Decimal(amount).mul(new Decimal(appStore().app.coin.denomination))
            .dividedBy(new Decimal(exchangeRate)).toString(),scale,denomination);
    }

    static currencyToCoin(amount,exchangeRate,denomination) {
        if (isNaN(amount) || !isStrictNumber(amount)) return null;
        // 真实币 乘面值 乘 汇率
        return this.roundToScale(new Decimal(amount).mul(new Decimal(denomination))
            .mul(new Decimal(exchangeRate)).toString(),appStore().app.coin.scale,appStore().app.coin.denomination);
    }

    static formatBy1000(amount){
        if (isNaN(amount) || !isStrictNumber(amount)) return null;
        let [intPartStr, decPartStr] = amount.toString().split(".");
        let intFormatted = intPartStr.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        let decPart =decPartStr? Number(decPartStr):0;
        return decPart ? `${intFormatted}.${decPart}` : intFormatted;
    }

    static roundToScale(amount,scale,denomination){
        if (isNaN(amount) || !isStrictNumber(amount)) return null;
        // 数量 除 面值 保留小数
        const number = new Decimal(amount).dividedBy(new Decimal(denomination)).toDP(scale,Decimal.ROUND_HALF_DOWN);
        const [intPart, decPart] = number.toString().split(".");
        return (decPart && '0' !== decPart) ? `${intPart}.${Number(decPart)}` : intPart;
    }
    static isStrictNumber(str) {
        return isStrictNumber(str);
    }

}