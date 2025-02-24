from quantlib.types cimport Natural, Spread

from libcpp cimport bool

from quantlib._quote cimport Quote
from quantlib.cashflows.rateaveraging cimport RateAveraging
from quantlib.handle cimport shared_ptr, Handle
from quantlib.time._date cimport Date
from quantlib.time._period cimport Period, Frequency
from quantlib.termstructures.helpers cimport Pillar
from quantlib.termstructures.yields._rate_helpers cimport RateHelper, RelativeDateRateHelper
from quantlib.indexes._ibor_index cimport OvernightIndex
from quantlib.time._calendar cimport Calendar
from quantlib.time.businessdayconvention cimport BusinessDayConvention

from .._yield_term_structure cimport YieldTermStructure

cdef extern from 'ql/termstructures/yield/oisratehelper.hpp' namespace 'QuantLib':
    cdef cppclass OISRateHelper(RelativeDateRateHelper):
        OISRateHelper(Natural settlementDays,
                      Period& tenor, # swap maturity
                      Handle[Quote]& fixedRate,
                      shared_ptr[OvernightIndex]& overnightIndex,
                      # exogenous discounting curve
                      Handle[YieldTermStructure]& discountingCurve, # = Handle<YieldTermStructure>()
                      bool telescopicValueDates, # False)
                      Natural paymentLag, # = 0
                      BusinessDayConvention paymentConvention, # = Following
                      Frequency paymentFrequency, #  = Annual
                      Calendar& paymentCalendar, # = Calendar()
                      Period& forwardStart, # = 0 * Days
                      Spread overnightSpread,
                      Pillar pillar, # = Pillar::LastRelevantDate,
                      Date customPillarDate, # = Date(),
                      RateAveraging averagingMethod,# = RateAveraging::Compound,
        ) except + # = 0.0

    cdef cppclass DatedOISRateHelper(RateHelper):
        DatedOISRateHelper(
            Date& startDate,
            Date& endDate,
            Handle[Quote]& fixedRate,
            shared_ptr[OvernightIndex]& overnightIndex,
            # exogenous discounting curve
            Handle[YieldTermStructure] discountingCurve,# = Handle<YieldTermStructure>(),
            bool telescopicValueDates, #= false,
            RateAveraging averagingMethod #= RateAveraging::Compound)
        ) except +
